import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:wasfaty_liv/Models/stat.dart';
import '../Rev_Orderdetails.dart';
import '../Rev_RoundButton.dart';

class Rev_stat extends StatefulWidget {
  @required
  String msg;
  @required
  Future<DocumentSnapshot> path;
  Rev_stat({this.path, this.msg});
  @override
  _Rev_statState createState() => _Rev_statState();
}

class _Rev_statState extends State<Rev_stat> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<DocumentSnapshot>(
        future: widget.path,
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
              return Center(
                child: CircularProgressIndicator(),
              );
            case ConnectionState.done:
              Stat stat = snapshot.data.exists
                  ? Stat.fromJson(snapshot.data.data())
                  : null;
              return snapshot.data.exists
                  ? snapshot.hasData
                      ? Column(
                          children: [
                            stat.nbrCommandeLOCAL != null
                                ? Rev_Orderdetails(
                                    label: "Nombre de Commande :",
                                    info: stat.nbrCommandeLOCAL.toString())
                                : Container(),
                            stat.nbrCommandeTerminerLOCAL != null
                                ? Rev_Orderdetails(
                                    label: "Nombre de Commande terminer :",
                                    info: stat.nbrCommandeTerminerLOCAL
                                        .toString())
                                : Container(),
                          ],
                        )
                      : Center(
                          child: CircularProgressIndicator(),
                        )
                  : Center(
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                          Rev_RoundButton(
                            isfile: false,
                            image: "assets/vide.png",
                          ),
                          Text(
                            widget.msg,
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                            textAlign: TextAlign.center,
                          )
                        ]));

            case ConnectionState.none:
              return Center(
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                    Rev_RoundButton(
                      isfile: false,
                      image: "assets/vide.png",
                    ),
                    Text(
                      widget.msg,
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    )
                  ]));
              break;
            case ConnectionState.active:
              return Center(
                child: CircularProgressIndicator(),
              );
              break;
          }
        });
  }
}
