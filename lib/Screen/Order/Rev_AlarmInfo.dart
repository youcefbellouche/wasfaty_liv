import 'package:flutter/material.dart';
import 'package:wasfaty_liv/Widget/Rev_Orderdetails.dart';
import 'package:wasfaty_liv/Widget/Rev_Appbar.dart';
import 'package:wasfaty_liv/models/Alarm.dart';

class Rev_AlarmInfo extends StatefulWidget {
  Alarm? alarm;

  Rev_AlarmInfo({this.alarm});

  @override
  _Rev_AlarmInfoState createState() => _Rev_AlarmInfoState();
}

class _Rev_AlarmInfoState extends State<Rev_AlarmInfo> {
  void ofPage() {
    Navigator.pop(context);
  }

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
      ) as PreferredSizeWidget?,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(top: 20),
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Rev_Orderdetails(
                    label: "N° de l'alarm :", info: widget.alarm!.id.toString()),
                Rev_Orderdetails(
                    label: "Nom du medicament :",
                    info: widget.alarm!.medicament),
                widget.alarm!.medicType != null
                    ? Rev_Orderdetails(
                        label: "N° de l'alarm :",
                        info: widget.alarm!.medicType.toString())
                    : Container(),
                widget.alarm!.quantity != null
                    ? Rev_Orderdetails(
                        label: "le nombre de medicament a prendre :",
                        info: widget.alarm!.quantity.toString())
                    : Container(),
                Rev_Orderdetails(
                  label: "Heure :",
                  info: widget.alarm!.heure < 10 && widget.alarm!.minute < 10
                      ? "0${widget.alarm!.heure}:0${widget.alarm!.minute}"
                      : widget.alarm!.heure < 10
                          ? "0${widget.alarm!.heure}:${widget.alarm!.minute}"
                          : widget.alarm!.minute < 10
                              ? "${widget.alarm!.heure}:0${widget.alarm!.minute}"
                              : "${widget.alarm!.heure}:${widget.alarm!.minute}",
                ),
                widget.alarm!.note != null
                    ? Rev_Orderdetails(
                        label: "Note :", info: widget.alarm!.note.toString())
                    : Container(),
                Rev_Orderdetails(
                    label: "Duré (jour) :", info: widget.alarm!.dure.toString()),
                Rev_Orderdetails(
                    label: "Jour d'interval :",
                    info: widget.alarm!.jourInterv.toString()),
                Rev_Orderdetails(
                    label: "Alarm faite par  :", info: widget.alarm!.alarmBy),
                SizedBox(height: 50),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
