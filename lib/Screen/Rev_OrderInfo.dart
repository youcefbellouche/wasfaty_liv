import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../Screen/Rev_HomePage.dart';
import '../Widget/Rev_Appbar.dart';
import '../Models/order.dart';
import '../Widget/Rev_Button.dart';
import '../Widget/Rev_Orderdetails.dart';
import '../Widget/Rev_Pop.dart';
import '../Widget/Rev_TextFeild.dart';

class Rev_OrderInfo extends StatefulWidget {
  Order order;

  Rev_OrderInfo({this.order});

  @override
  _Rev_OrderInfoState createState() => _Rev_OrderInfoState();
}

class _Rev_OrderInfoState extends State<Rev_OrderInfo> {
  void ofPage() {
    Navigator.pop(context);
  }

  String devis;
  final _formKey = GlobalKey<FormState>();
  TextEditingController devisController;

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
      ),
      body: FutureBuilder<DocumentSnapshot>(
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
                                      fontSize: 25,
                                      fontWeight: FontWeight.bold),
                                ),
                                Center(
                                  child: Container(
                                    height: MediaQuery.of(context).size.height *
                                        0.3,
                                    child: Image(
                                      image:
                                          NetworkImage(widget.order.ordonnance),
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
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.3,
                                          child: Image(
                                            image: NetworkImage(
                                                widget.order.carteChifa),
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
                          label: "Nom complet du client :",
                          info: snapshot.data['name']),
                      Rev_Orderdetails(
                          label: "Numéro de téléphone du client :",
                          info: snapshot.data['tel']),
                      Rev_Orderdetails(
                          label: "Email du client :",
                          info: snapshot.data['email']),
                      Rev_Orderdetails(
                          label: "Nom complet du patient :",
                          info: widget.order.bname),
                      Rev_Orderdetails(
                          label: "Moyen de livraison :",
                          info: widget.order.livraison),
                      Rev_Orderdetails(
                          label: "Adresse :", info: widget.order.adresse),
                      SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Rev_Button(
                            onpressed: () {},
                            label: "Refuser",
                            color: Colors.redAccent,
                          ),
                          Rev_Button(
                            onpressed: () {
                              print('test');
                              devisPop(context);
                            },
                            label: "Valider",
                            color: Colors.green,
                          ),
                        ],
                      ),
                      SizedBox(height: 20),
                    ],
                  ),
                )
              : Center(child: CircularProgressIndicator());
        },
      ),
    );
  }

  devisPop(context) {
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
                    onChanged: (value) => devis = value,
                    textEditingController: devisController,
                    label: "Devis",
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
                                    .update(
                                        {"status": "devis", "devis": devis});
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
