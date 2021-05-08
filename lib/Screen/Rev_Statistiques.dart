import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:wasfaty_liv/Widget/Rev_Drawer.dart';
import 'package:wasfaty_liv/Widget/Rev_Appbar.dart';
import 'package:wasfaty_liv/Widget/Statistique/Rev_stat.dart';

class Rev_Statistiques extends StatefulWidget {
  @override
  _Rev_StatistiquesState createState() => _Rev_StatistiquesState();
}

class _Rev_StatistiquesState extends State<Rev_Statistiques> {
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();
  DateFormat feild = DateFormat().add_yMMMMd();
  DateTime? time = DateTime.now();
  DateTime? _pick = new DateTime(
      DateTime.now().year, DateTime.now().month, DateTime.now().day);
  void openDrawer() {
    _scaffoldKey.currentState!.openDrawer();
  }

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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      drawer: Rev_Drawer(),
      appBar: Rev_Appbar(
        context,
        AppBar().preferredSize.height,
        openDrawer,
        Icon(
          Icons.menu,
          color: Theme.of(context).primaryColor,
        ),
      ) as PreferredSizeWidget?,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.all(12),
              child: TextFormField(
                readOnly: true,
                onTap: () async {
                  time = await showDatePicker(
                      context: context,
                      initialDate: _pick!,
                      firstDate: DateTime(2020, 10, 7),
                      lastDate: DateTime(DateTime.now().year,
                          DateTime.now().month, DateTime.now().day),
                      builder: (BuildContext context, Widget? child) {
                        return Theme(
                          child: child!,
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
                    if (time != null) {
                      _pick = time;
                    } else {
                      time = DateTime.now();
                    }
                  });
                },
                textAlign: TextAlign.center,
                decoration: InputDecoration(
                  labelText: "Choisissez un jour ",
                  hintText: "${time!.day}/${time!.month}/${time!.year}",
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
            time != null
                ? Center(
                    child: Text(
                      'Jour :',
                      style:
                          TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                    ),
                  )
                : Container(),
            SizedBox(height: 8),
            time != null
                ? Rev_stat(
                    msg: "Vous n\'avez pas de statistiques ce jour-ci",
                    path: FirebaseFirestore.instance
                        .collection("Livreur")
                        .doc(FirebaseAuth.instance.currentUser!.uid)
                        .collection('Statistique')
                        .doc(time!.year.toString())
                        .collection("month")
                        .doc(time!.month.toString())
                        .collection("day")
                        .doc(time!.day.toString())
                        .get(),
                  )
                : Container(),
            SizedBox(height: 8),
            time != null
                ? Divider(
                    height: 5,
                    color: Theme.of(context).primaryColor,
                  )
                : Container(),
            SizedBox(height: 2),
            time != null
                ? Center(
                    child: Text(
                      'Mois :',
                      style:
                          TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                    ),
                  )
                : Container(),
            SizedBox(height: 8),
            time != null
                ? Rev_stat(
                    msg: "Vous n\'avez pas de statistiques ce mois-ci",
                    path: FirebaseFirestore.instance
                        .collection("Livreur")
                        .doc(FirebaseAuth.instance.currentUser!.uid)
                        .collection('Statistique')
                        .doc(time!.year.toString())
                        .collection("month")
                        .doc(time!.month.toString())
                        .get(),
                  )
                : Container(),
            SizedBox(height: 8),
            time != null
                ? Divider(
                    height: 5,
                    color: Theme.of(context).primaryColor,
                  )
                : Container(),
            SizedBox(height: 2),
            time != null
                ? Center(
                    child: Text(
                      'Année :',
                      style:
                          TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                    ),
                  )
                : Container(),
            SizedBox(height: 8),
            time != null
                ? Rev_stat(
                    msg: "Vous n\'avez pas de statistiques cette année",
                    path: FirebaseFirestore.instance
                        .collection("Livreur")
                        .doc(FirebaseAuth.instance.currentUser!.uid)
                        .collection('Statistique')
                        .doc(time!.year.toString())
                        .get(),
                  )
                : Container(),
            SizedBox(height: 8),
          ],
        ),
      ),
    );
  }
}
