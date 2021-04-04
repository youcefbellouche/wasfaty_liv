import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:wasfaty_liv/Widget/Rev_Orderdetails.dart';
import 'package:wasfaty_liv/Widget/Rev_OrderdetailsButton.dart';

class Rev_PharmacieInfo extends StatefulWidget {
  String pharmacieid;

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
              return snapshot.hasData
                  ? SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          SizedBox(height: 30),
                          Rev_Orderdetails(
                              label: "N° de la Pharmacie :",
                              info: snapshot.data['id']),
                          Rev_Orderdetails(
                              label: "Nom de la Pharmacie :",
                              info: snapshot.data['name']),
                          Rev_OrderdetailsButton(
                            label: "Numéro de téléphone de la Pharmacie :",
                            info: snapshot.data['phone'],
                            phone: snapshot.data['phone'],
                          ),
                          Rev_Orderdetails(
                            label: "Email de la Pharmacie :",
                            info: snapshot.data['email'],
                          ),
                          Rev_Orderdetails(
                              label: "Wilaya de la Pharmacie :",
                              info: snapshot.data['wilaya']),
                          Rev_Orderdetails(
                              label: "Adresse de la Pharmacie :",
                              info: snapshot.data['adresse']),
                          SizedBox(height: 20),
                        ],
                      ),
                    )
                  : Center(child: CircularProgressIndicator());
            },
          )
        : Center(child: Text("cettte commande n'a pas de pharmacie"));
  }
}
