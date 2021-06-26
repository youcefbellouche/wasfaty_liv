import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:wasfaty_liv/Models/livreur.dart';
import 'package:wasfaty_liv/Widget/Rev_Appbar.dart';
import 'package:wasfaty_liv/Widget/Rev_Orderdetails.dart';

import 'Rev_phoneUpdate.dart';

class Rev_ProfileInfo extends StatefulWidget {
  String uid;
  Rev_ProfileInfo({Key? key, required this.uid}) : super(key: key);

  @override
  _Rev_ProfileInfoState createState() => _Rev_ProfileInfoState();
}

class _Rev_ProfileInfoState extends State<Rev_ProfileInfo> {
  Livreur? pharm;
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    void ofPage() {
      Navigator.pop(context);
    }

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
        body: loading
            ? Center(
                child: CircularProgressIndicator(),
              )
            : Center(
                child: Column(
                  children: [
                    Expanded(
                      child: StreamBuilder<DocumentSnapshot>(
                        stream: FirebaseFirestore.instance
                            .collection('Livreur')
                            .doc(widget.uid)
                            .snapshots(),
                        builder: (c, snapshot) {
                          if (snapshot.hasData) {
                            Livreur livreur = Livreur.fromJson(
                                snapshot.data!.data() as Map<String, dynamic>);
                            pharm = livreur;
                            return SingleChildScrollView(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  SizedBox(height: 30),
                                  Rev_Orderdetails(
                                      label: "Nom Complet :",
                                      info: livreur.name),
                                  Container(
                                    child: Column(children: [
                                      Text(
                                        "Numéro de téléphone :",
                                        textAlign: TextAlign.left,
                                        style: TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Container(
                                            color:
                                                Theme.of(context).primaryColor,
                                            height: 35,
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.9,
                                            child: Center(
                                                child: Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Container(
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                      0.125,
                                                ),
                                                Center(
                                                  child: Text(
                                                    livreur.phone.toString(),
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                ),
                                                IconButton(
                                                    onPressed: () {
                                                      Navigator.push(
                                                          context,
                                                          MaterialPageRoute(
                                                              builder: (context) =>
                                                                  Rev_phoneUpdate(
                                                                    uid: FirebaseAuth
                                                                        .instance
                                                                        .currentUser!
                                                                        .uid,
                                                                    oldphone:
                                                                        livreur
                                                                            .phone,
                                                                  )));
                                                    },
                                                    icon: Icon(
                                                      Icons.edit_outlined,
                                                      color: Colors.white,
                                                    )),
                                              ],
                                            ))),
                                      ),
                                    ]),
                                  ),
                                  Rev_Orderdetails(
                                    label: "Email :",
                                    info: livreur.email,
                                  ),
                                  Rev_Orderdetails(
                                    label: "Wilaya :",
                                    info: livreur.wilaya,
                                  ),
                                  Rev_Orderdetails(
                                    label: "Daira :",
                                    info: livreur.daira,
                                  ),
                                  Rev_Orderdetails(
                                    label: "Adresse :",
                                    info: livreur.adress,
                                  ),
                                ],
                              ),
                            );
                          } else {
                            return Center(child: CircularProgressIndicator());
                          }
                        },
                      ),
                    ),
                  ],
                ),
              ));
  }
}
