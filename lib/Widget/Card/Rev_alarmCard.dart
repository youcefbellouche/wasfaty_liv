import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:wasfaty_liv/Screen/Order/Rev_AlarmInfo.dart';
import 'package:wasfaty_liv/models/Alarm.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Rev_alarmCard extends StatefulWidget {
  @required
  Alarm? alarm;
  String? patientId;

  Rev_alarmCard({this.alarm, this.patientId});
  @override
  _Rev_alarmCardState createState() => _Rev_alarmCardState();
}

class _Rev_alarmCardState extends State<Rev_alarmCard> {
  bool _switchValue = false;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => Rev_AlarmInfo(
                      alarm: widget.alarm,
                    )));
      },
      child: Container(
        height: 100,
        decoration: BoxDecoration(
            gradient: new LinearGradient(
              colors: [
                Theme.of(context).primaryColor.withOpacity(0.9),
                Theme.of(context).accentColor.withOpacity(0.9)
              ],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              stops: [0.0, 1.0],
              tileMode: TileMode.clamp,
            ),
            borderRadius: BorderRadius.all(
              Radius.circular(13),
            )),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 8, 0, 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    widget.alarm!.heure < 10 && widget.alarm!.minute < 10
                        ? "0${widget.alarm!.heure}:0${widget.alarm!.minute}"
                        : widget.alarm!.heure < 10
                            ? "0${widget.alarm!.heure}:${widget.alarm!.minute}"
                            : widget.alarm!.minute < 10
                                ? "${widget.alarm!.heure}:0${widget.alarm!.minute}"
                                : "${widget.alarm!.heure}:${widget.alarm!.minute}",
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                  SizedBox(height: 8),
                  Text(
                    widget.alarm!.medicament,
                    style: TextStyle(fontSize: 15, color: Colors.white),
                  )
                ],
              ),
            ),
            Padding(
                padding: const EdgeInsets.fromLTRB(0, 15, 15, 15),
                child: IconButton(
                  icon: Icon(Icons.delete),
                  onPressed: () {
                    FirebaseFirestore.instance
                        .collection("Patients")
                        .doc(widget.patientId)
                        .collection("Alarm")
                        .doc(widget.alarm!.id.toString())
                        .delete();
                    Navigator.pop(context);
                  },
                  color: Colors.white,
                )),
          ],
        ),
      ),
    );
  }
}
