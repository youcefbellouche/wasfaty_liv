import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:wasfaty_liv/Widget/Card/Rev_alarmCard.dart';
import 'package:wasfaty_liv/models/Alarm.dart';
import 'package:wasfaty_liv/Widget/Rev_vide.dart';
import 'Rev_AlarmForm.dart';

class Rev_AlarmList extends StatefulWidget {
  @required
  String? orderId;
  @required
  String? patientId;
  Rev_AlarmList({this.orderId, this.patientId});
  @override
  _Rev_AlarmListState createState() => _Rev_AlarmListState();
}

class _Rev_AlarmListState extends State<Rev_AlarmList> {
  void ofPage() {
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: Container(
          child: Icon(Icons.add),
        ),
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => Rev_AlarmForm(
                        patientId: widget.patientId,
                        orderId: widget.orderId,
                      )));
        },
      ),
      body: FutureBuilder<QuerySnapshot>(
          future: FirebaseFirestore.instance
              .collection('Patients')
              .doc(widget.patientId)
              .collection("Alarm")
              .where("orderId", isEqualTo: widget.orderId)
              .get(),
          builder: (context, snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.waiting:
                return Center(
                  child: CircularProgressIndicator(),
                );
              case ConnectionState.done:
                if (snapshot.hasData) {
                  return ListView.builder(
                      physics: const AlwaysScrollableScrollPhysics(),
                      itemCount: snapshot.data!.docs.length,
                      itemBuilder: (context, index) {
                        Alarm data = Alarm.fromJson(snapshot.data!.docs[index]
                            .data() as Map<String, dynamic>);
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Dismissible(
                            direction: DismissDirection.endToStart,
                            background: slideLeft(),
                            key: Key(data.medicament.toString()),
                            onDismissed: (direction) {
                              if (direction == DismissDirection.endToStart) {}
                              FirebaseFirestore.instance
                                  .collection("Patients")
                                  .doc(widget.patientId)
                                  .collection("Alarm")
                                  .doc(data.id.toString())
                                  .delete();
                              Navigator.pop(context);
                            },
                            child: Container(
                              color: Colors.transparent,
                              child: Rev_alarmCard(
                                alarm: data,
                                patientId: widget.patientId,
                              ),
                            ),
                          ),
                        );
                      });
                } else {
                  return Rev_vide(
                    msg: "Cette commande n'a pas d'Alarms",
                    img: "assets/vide.png",
                  );
                }
              case ConnectionState.none:
                Rev_vide(
                  msg: "Cette commande n'a pas d'Alarm",
                  img: "assets/vide.png",
                );
                break;
              case ConnectionState.active:
                return Center(
                  child: CircularProgressIndicator(),
                );
            }
            return Container();
          }),
    );
  }

  Widget slideLeft() {
    return Container(
      decoration: BoxDecoration(
          color: Color(0xFFe57323),
          borderRadius: BorderRadius.all(
            Radius.circular(13),
          )),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          Icon(
            Icons.delete,
            color: Colors.white,
          ),
          Text(
            "Effacer",
            style: TextStyle(color: Colors.white),
            textAlign: TextAlign.right,
          ),
          SizedBox(
            width: 20,
          ),
        ],
      ),
    );
  }
}
