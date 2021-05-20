import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:wasfaty_liv/Models/Pharmacie.dart';
import 'package:wasfaty_liv/Widget/Rev_Orderdetails.dart';
import 'package:wasfaty_liv/Widget/Rev_OrderdetailsButton.dart';

import 'package:wasfaty_liv/Widget/Rev_RoundButton.dart';

class Rev_PharmacieInfo extends StatefulWidget {
  String? pharmacieid;

  Rev_PharmacieInfo({this.pharmacieid});

  @override
  _Rev_PharmacieInfoState createState() => _Rev_PharmacieInfoState();
}

class _Rev_PharmacieInfoState extends State<Rev_PharmacieInfo> {
  void ofPage() {
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return widget.pharmacieid != null
        ? FutureBuilder<DocumentSnapshot>(
            future: FirebaseFirestore.instance
                .collection('Pharmacie')
                .doc(widget.pharmacieid)
                .get(),
            builder: (c, snapshot) {
              Pharmacie pharmacie = Pharmacie.fromJson(
                  snapshot.data!.data() as Map<String, dynamic>);
              return snapshot.hasData
                  ? SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          SizedBox(height: 30),
                          Rev_Orderdetails(
                              label: "Nom de la Pharmacie :",
                              info: pharmacie.name),
                          Rev_OrderdetailsButton(
                            label: "Numéro de téléphone de la Pharmacie :",
                            info: pharmacie.phone,
                            phone: pharmacie.phone,
                            localisation: false,
                          ),
                          Rev_Orderdetails(
                            label: "Email de la Pharmacie :",
                            info: pharmacie.email,
                          ),
                          Rev_Orderdetails(
                              label: "Wilaya de la Pharmacie :",
                              info: pharmacie.wilaya),
                          Rev_Orderdetails(
                              label: "Adresse de la Pharmacie :",
                              info: pharmacie.daira),
                          Rev_OrderdetailsButton(
                            label: "Adresse de la Pharmacie :",
                            info: "Google Maps ->",
                            localisation: true,
                            lat: pharmacie.lat,
                            long: pharmacie.long,
                          ),
                          SizedBox(height: 20),
                        ],
                      ),
                    )
                  : Center(child: CircularProgressIndicator());
            },
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
                  "Cette commande n'a pas de pharmacie",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                )
              ]));
  }
}
