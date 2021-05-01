import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:wasfaty_liv/Widget/Rev_Appbar.dart';
import 'package:wasfaty_liv/Widget/Rev_Button.dart';
import 'package:wasfaty_liv/Widget/Rev_DropDown.dart';
import 'package:wasfaty_liv/Widget/Rev_TextFeild.dart';
import 'package:wasfaty_liv/Widget/Rev_timePicker.dart';
import 'package:wasfaty_liv/models/Alarm.dart';
import 'package:intl/intl.dart';
import '../Rev_HomePage.dart';

class Rev_AlarmForm extends StatefulWidget {
  String orderId;
  String patientId;
  Rev_AlarmForm({this.orderId, this.patientId});
  @override
  _Rev_AlarmFormState createState() => _Rev_AlarmFormState();
}

class _Rev_AlarmFormState extends State<Rev_AlarmForm> {
  void ofPage() {
    Navigator.pop(context);
  }

  DateFormat feild = DateFormat().add_yMMMMd();
  DateTime timeD = DateTime.now();
  DateTime _pick = new DateTime(
      DateTime.now().year, DateTime.now().month, DateTime.now().day);

  DateTime newDate;
  MaterialColor kPrimaryColor = const MaterialColor(
    0xff218171,
    const <int, Color>{
      50: const Color(0xff218171),
      100: const Color(0xff218171),
      200: const Color(0xff218171),
      300: const Color(0xff218171),
      400: const Color(0xff218171),
      500: const Color(0xff218171),
      600: const Color(0xff218171),
      700: const Color(0xff218171),
      800: const Color(0xff218171),
      900: const Color(0xff218171),
    },
  );
  Alarm alarm = new Alarm();

  final _formKey = GlobalKey<FormState>();
  List<String> wil = ['test1', 'test2'];

  String valuew;
  TimeOfDay time = TimeOfDay.now();
  TimeOfDay pick =
      new TimeOfDay(hour: TimeOfDay.now().hour, minute: TimeOfDay.now().minute);

  List<String> nbrFois = [
    'Tout les jours',
    '1 jour sur 2',
    '1 jour sur 3',
    '1 jour sur 4',
    '1 jour sur 5',
    '1 jour sur 6',
    '1 jour sur 7'
  ];
  String valuenbrFois;
  String name;
  TextEditingController controllerTime = new TextEditingController();
  TextEditingController controllerDate = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Rev_Appbar(
        context,
        AppBar().preferredSize.height,
        ofPage,
        Icon(
          Icons.arrow_back,
          color: Theme.of(context).primaryColor,
        ),
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          children: [
            Rev_TextFeild(
              label: "Nom du Medicament",
              mdp: false,
              onChanged: (value) => alarm.medicament = value,
              validator: (input) =>
                  input.isEmpty ? "Donnez le nom du Medicament" : null,
              textInputType: TextInputType.name,
            ),
            Rev_DropDown(
              validator: (String item) {
                if (item == null)
                  return "Donnez le type du Medicament";
                else
                  return null;
              },
              hint: "Type du medicament",
              valuew: valuew,
              wil: wil,
              onchanged: (String value) {
                setState(() {
                  valuew = value;
                  print(valuew);
                });
              },
            ),
            Rev_TextFeild(
              label: "Quantité a prendre",
              mdp: false,
              onChanged: (value) => alarm.quantity = value,
              validator: (input) => input.isEmpty
                  ? "Donnez la quantité a prendre"
                  : int.parse(input) < 1
                      ? "Donner une quantité valide"
                      : null,
              textInputType: TextInputType.number,
            ),
            Container(
              padding: EdgeInsets.all(12),
              child: TextFormField(
                maxLines: null,
                onChanged: (value) => alarm.note = value,
                style: const TextStyle(color: Colors.black),
                keyboardType: TextInputType.multiline,
                decoration: InputDecoration(
                    labelStyle: const TextStyle(color: Colors.black),
                    border: OutlineInputBorder(
                        borderSide: const BorderSide(color: Color(0xff218171)),
                        borderRadius: BorderRadius.circular(20)),
                    enabledBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: Color(0xff218171)),
                        borderRadius: BorderRadius.circular(20)),
                    labelText: "Note"),
              ),
            ),
            Rev_DropDown(
              validator: (String item) {
                if (item == null)
                  return "Donnez le nombre de fois par semaine";
                else
                  return null;
              },
              hint: "Nombre de fois par semaine",
              valuew: valuenbrFois,
              wil: nbrFois,
              onchanged: (String value) {
                switch (value) {
                  case 'Tout les jours':
                    {
                      setState(() {
                        alarm.jourInterv = 1;
                      });
                    }
                    break;
                  case "1 jour sur 2":
                    {
                      setState(() {
                        alarm.jourInterv = 2;
                      });
                    }
                    break;
                  case "1 jour sur 3":
                    {
                      setState(() {
                        alarm.jourInterv = 3;
                      });
                    }
                    break;
                  case "1 jour sur 4":
                    {
                      setState(() {
                        alarm.jourInterv = 4;
                      });
                    }
                    break;
                  case "1 jour sur 5":
                    {
                      setState(() {
                        alarm.jourInterv = 5;
                      });
                    }
                    break;
                  case "1 jour sur 6":
                    {
                      setState(() {
                        alarm.jourInterv = 6;
                      });
                    }
                    break;
                  case "1 jour sur 7":
                    {
                      setState(() {
                        alarm.jourInterv = 7;
                      });
                    }
                    break;
                  default:
                    {}
                    break;
                }
              },
            ),
            Rev_TextFeild(
              label: "Duré (jour)",
              mdp: false,
              onChanged: (value) => alarm.dure = int.parse(value),
              textInputType: TextInputType.number,
              validator: (input) =>
                  input.isEmpty ? "Donnez le nombre de jour" : null,
            ),
            Container(
              padding: EdgeInsets.all(12),
              child: TextFormField(
                controller: controllerDate,
                validator: (input) =>
                    input.isEmpty ? "Donnez le date du debut de l'alarm" : null,
                readOnly: true,
                onTap: () async {
                  timeD = await showDatePicker(
                      context: context,
                      // initialEntryMode: DatePickerEntryMode.input,
                      initialDate: _pick,
                      firstDate: DateTime(2020, 10, 7),
                      lastDate: DateTime(DateTime.now().year + 1,
                          DateTime.now().month + 12, DateTime.now().day),
                      builder: (BuildContext context, Widget child) {
                        return Theme(
                          child: child,
                          data: ThemeData.light().copyWith(
                            colorScheme: ColorScheme.fromSwatch(
                              primarySwatch: kPrimaryColor,
                              primaryColorDark: Colors.green,
                              accentColor: Colors.green,
                            ),
                            dialogBackgroundColor: Colors.white,
                          ),
                        );
                      });

                  setState(() {
                    if (timeD != null) {
                      _pick = timeD;
                      controllerDate.text =
                          "${timeD.day}/${timeD.month}/${timeD.year}";
                    } else {
                      timeD = DateTime.now();
                    }
                  });
                },
                textAlign: TextAlign.center,
                decoration: InputDecoration(
                  labelText: "Choisissez un jour ",
                  hintText: "${timeD.day}/${timeD.month}/${timeD.year}",
                  hintStyle: TextStyle(color: Colors.black),
                  labelStyle: const TextStyle(color: Colors.black),
                  border: OutlineInputBorder(
                      borderSide: const BorderSide(color: Color(0xff218171)),
                      borderRadius: BorderRadius.circular(20)),
                  enabledBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: Color(0xff218171)),
                      borderRadius: BorderRadius.circular(20)),
                ),
              ),
            ),
            Rev_timePicker(
              validator: (input) =>
                  input.isEmpty ? "Donnez l'heure et la minute" : null,
              time: time,
              controller: controllerTime,
              onchanged: (value) {
                setState(() {
                  if (value != null) {
                    time = value;
                    controllerTime.text = "${time.format(context)}";
                  }
                });
              },
              label: "Heure",
            ),
            Padding(
              padding: const EdgeInsets.only(
                  top: 8.0, left: 15, right: 15, bottom: 15),
              child: Rev_Button(
                label: "Valider",
                onpressed: () async {
                  if (_formKey.currentState.validate()) {
                    print('validate');
                    setState(() {
                      alarm.id = Random().nextInt(10000000);
                      newDate = new DateTime(timeD.year, timeD.month, timeD.day,
                          time.hour, time.minute);
                      alarm.hours = newDate;
                    });
                    await FirebaseFirestore.instance
                        .collection("Patients")
                        .doc(widget.patientId)
                        .collection("Alarm")
                        .doc(alarm.id.toString())
                        .set({
                      "id": alarm.id,
                      "nom du medicament": alarm.medicament,
                      "type du medicament": alarm.medicType,
                      "note": alarm.note,
                      "quantity": alarm.quantity,
                      "duré": alarm.dure,
                      "jourInterv": alarm.jourInterv,
                      "heure": alarm.hours.hour,
                      "minute": alarm.hours.minute,
                      "date": alarm.hours.millisecondsSinceEpoch,
                      "orderId": widget.orderId,
                      "alarmBy": "livreur",
                      "livreurId": FirebaseAuth.instance.currentUser.uid,
                    });
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => Rev_HomePage()));
                  }
                },
                color: Theme.of(context).accentColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
