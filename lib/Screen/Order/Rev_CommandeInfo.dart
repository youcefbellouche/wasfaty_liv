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
                        label: "Prix Total :", info: widget.order.devis),
                    Rev_Orderdetails(
                        label: "Nom complet du client :",
                        info: snapshot.data['name']),
                    Rev_OrderdetailsButton(
                        label: "Numéro de téléphone du client :",
                        info: snapshot.data['tel'],
                        phone: snapshot.data['tel']),
                    Rev_Orderdetails(
                        label: "Nom complet du patient :",
                        info: widget.order.bname),
                    Rev_Orderdetails(
                        label: "Generique", info: widget.order.generique),
                    Rev_Orderdetails(
                        label: "Date de Commande :",
                        info: DateTime.fromMillisecondsSinceEpoch(
                                widget.order.date)
                            .toString()),
                    Rev_Orderdetails(
                        label: "Statut :", info: widget.order.status),
                    widget.order.dateAnnuler != null
                        ? Rev_Orderdetails(
                            label: "La Commande a été annuler le :",
                            info: DateTime.fromMillisecondsSinceEpoch(
                                    widget.order.dateAnnuler)
                                .toString())
                        : Container(),
                    widget.order.dateTeminer != null
                        ? Rev_Orderdetails(
                            label: "La Commande a été effectuée le :",
                            info: DateTime.fromMillisecondsSinceEpoch(
                                    widget.order.dateTeminer)
                                .toString())
                        : Container(),
                    widget.order.annulerBy != null
                        ? Rev_Orderdetails(
                            label: "Annuler Par :",
                            info: widget.order.annulerBy)
                        : Container(),
                    widget.order.noteAnnuler != null
                        ? Rev_Orderdetails(
                            label: "Note d'annulation :",
                            info: widget.order.noteAnnuler)
                        : Container(),
                    Rev_Orderdetails(
                        label: "Wilaya :", info: widget.order.wilaya),
                    widget.order.daira != null
                        ? Rev_Orderdetails(
                            label: "Daira :", info: widget.order.daira)
                        : Container(),
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
                                label: "Annuler",
                                color: Colors.redAccent,
                              ),
                              Rev_Button(
                                onpressed: () async {
                                  SharedPreferences prefs =
                                      await SharedPreferences.getInstance();

                                  String uid = prefs.getString('id');
                                  await FirebaseFirestore.instance
                                      .collection(widget.collection)
                                      .doc(widget.order.orderId)
                                      .update({
                                    "status": "terminer",
                                    "DateTerminer":
                                        DateTime.now().millisecondsSinceEpoch
                                  });

                                  Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => Rev_HomePage(
                                                id: uid,
                                              )));
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
                    validator: (input) => input.isEmpty
                        ? "Donner la raison de l'annulation de la commande "
                        : null,
                    label: "Note",
                    textInputType: TextInputType.text,
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
                                // print('envoyer');
                                if (_formKey.currentState.validate()) {
                                  SharedPreferences prefs =
                                      await SharedPreferences.getInstance();

                                  String uid = prefs.getString('id');

                                  await FirebaseFirestore.instance
                                      .collection(widget.collection)
                                      .doc(widget.order.orderId)
                                      .update({
                                    "status": "annuler",
                                    "noteAnnuler": noteA,
                                    "annulerBy": "livreur",
                                    "DateAnnuler":
                                        DateTime.now().millisecondsSinceEpoch,
                                  });

                                  Navigator.pop(context);

                                  Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => Rev_HomePage(
                                                id: uid,
                                              )));
                                }
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