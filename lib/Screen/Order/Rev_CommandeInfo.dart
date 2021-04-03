import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:wasfaty_liv/Models/order.dart';
import 'package:wasfaty_liv/Widget/Rev_Button.dart';
import 'package:wasfaty_liv/Widget/Rev_Orderdetails.dart';
import 'package:wasfaty_liv/Widget/Rev_OrderdetailsButton.dart';
import 'package:wasfaty_liv/Widget/Rev_TextFeild.dart';

import '../Rev_HomePage.dart';

class Rev_CommandeInfo extends StatefulWidget {
  Order order;
  String collection;

  Rev_CommandeInfo({this.order, this.collection});

  @override
  _Rev_CommandeInfoState createState() => _Rev_CommandeInfoState();
}

class _Rev_CommandeInfoState extends State<Rev_CommandeInfo> {
  void ofPage() {
    Navigator.pop(context);
  }

  String devis;
  final _formKey = GlobalKey<FormState>();
  TextEditingController devisController;
  String id;
  String noteA;
  TextEditingController noteController;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<DocumentSnapshot>(
      future: FirebaseFirestore.instance
          .collection('Patients')
          .doc(widget.order.uid)
          .get(),
      builder: (c, snapshot) {
        return snapshot.hasData
            ? SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: widget.order.carteChifa != null
                          ? MainAxisAlignment.spaceEvenly
                          : MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Column(
                            children: [
                              Text(
                                "Ordonnance :",
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                    fontSize: 25, fontWeight: FontWeight.bold),
                              ),
                              Center(
                                child: Container(
                                  height:
                                      MediaQuery.of(context).size.height * 0.3,
                                  child: InkWell(
                                    onTap: () => verifyImage(
                                        context, widget.order.ordonnance),
                                    child: Image(
                                      image:
                                          NetworkImage(widget.order.ordonnance),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        widget.order.carteChifa != null
                            ? Padding(
                                padding: const EdgeInsets.all(12.0),
                                child: Column(
                                  children: [
                                    Text(
                                      "Carte Chifa :",
                                      textAlign: TextAlign.left,
                                      style: TextStyle(
                                          fontSize: 25,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Center(
                                      child: Container(
                                        height:
                                            MediaQuery.of(context).size.height *
                                                0.3,
                                        child: InkWell(
                                          onTap: () => verifyImage(
                                              context, widget.order.ordonnance),
                                          child: Image(
                                            image: NetworkImage(
                                                widget.order.carteChifa),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            : Container()
                      ],
                    ),
                    Rev_Orderdetails(
                        label: "N° de Commande :", info: widget.order.orderId),
                    Rev_Orderdetails(
                        label: "Nom complet du client :",
                        info: snapshot.data['name']),
                    Rev_OrderdetailsButton(
                        label: "Numéro de téléphone du client :",
                        info: snapshot.data['tel'],
                        phone: snapshot.data['tel']),
                    Rev_Orderdetails(
                      label: "Email du client :",
                      info: snapshot.data['email'],
                    ),
                    Rev_Orderdetails(
                        label: "Nom complet du patient :",
                        info: widget.order.bname),
                    Rev_Orderdetails(
                        label: "Generique", info: widget.order.generique),
                    Rev_Orderdetails(
                        label: "Moyen de livraison :",
                        info: widget.order.livraison),
                    Rev_Orderdetails(
                        label: "Adresse :", info: widget.order.adresse),
                    SizedBox(height: 10),
                    widget.order.status == "en livraison"
                        ? Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Rev_Button(
                                onpressed: () async {
                                  anulOrder(context);
                                },
                                label: "Refuser",
                                color: Colors.redAccent,
                              ),
                              Rev_Button(
                                onpressed: () {
                                  print('test');
                                },
                                label: "Terminer",
                                color: Colors.green,
                              ),
                            ],
                          )
                        : Container(),
                    SizedBox(height: 70),
                  ],
                ),
              )
            : Center(child: CircularProgressIndicator());
      },
    );
  }

  verifyImage(context, file) {
    return showDialog(
        context: context,
        builder: (con) {
          return SimpleDialog(
            backgroundColor: Colors.transparent,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(20.0))),
            children: [
              Container(
                  decoration: BoxDecoration(
                      border: Border.all(width: 2, color: Colors.grey)),
                  child: Image.network(file, fit: BoxFit.cover)),
            ],
          );
        });
  }

  anulOrder(context) {
    return showDialog(
        context: context,
        builder: (con) {
          return Form(
            key: _formKey,
            child: Container(
              color: Colors.grey[300],
              child: SimpleDialog(
                backgroundColor: Colors.transparent,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(20.0))),
                children: [
                  Rev_TextFeild(
                    onChanged: (value) => noteA = value,
                    textEditingController: noteController,
                    label: "Note",
                    textInputType: TextInputType.number,
                    mdp: false,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ButtonTheme(
                      child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            RaisedButton(
                              shape: RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(20.0))),
                              color: Colors.redAccent,
                              child: Text('Anuuler'),
                              onPressed: () {
                                Navigator.pop(context);
                              },
                            ),
                            RaisedButton(
                              shape: RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(20.0))),
                              color: Colors.greenAccent,
                              child: Text('Envoyer'),
                              onPressed: () async {
                                print('envoyer');
                                await FirebaseFirestore.instance
                                    .collection("Commande")
                                    .doc(widget.order.orderId)
                                    .update({
                                  "status": "annuler",
                                  "noteAnnuler": noteA,
                                  "annulerBy": "livreur"
                                });
                                Navigator.pop(context);
                                Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => Rev_HomePage()));
                              },
                            ),
                          ]),
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }
}
