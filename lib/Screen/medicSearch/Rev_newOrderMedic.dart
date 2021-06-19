import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:wasfaty_liv/Models/order.dart';
import 'package:wasfaty_liv/Widget/Card/Rev_OrderCard.dart';
import 'package:wasfaty_liv/Widget/Rev_RoundButton.dart';

class Rev_newOrderMedic extends StatefulWidget {
  String? where;
  Rev_newOrderMedic({this.where});

  @override
  _Rev_newOrderMedicState createState() => _Rev_newOrderMedicState();
}

class _Rev_newOrderMedicState extends State<Rev_newOrderMedic> {
  Order? model;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(bottom: 60),
      child: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection("RMedLocal")
            .where("livreurId",
                isEqualTo: FirebaseAuth.instance.currentUser!.uid)
            .where("status", isEqualTo: widget.where)
            .snapshots(),
        builder: (context, snapshot1) {
          return !snapshot1.hasData
              ? Center(child: CircularProgressIndicator())
              : FutureBuilder<QuerySnapshot>(
                  future: FirebaseFirestore.instance
                      .collection("RMedEtr")
                      .where("livreurId",
                          isEqualTo: FirebaseAuth.instance.currentUser!.uid)
                      .where("status", isEqualTo: widget.where)
                      .get(),
                  builder: (cotnext, snapshot2) {
                    return !snapshot2.hasData
                        ? Center(
                            child: CircularProgressIndicator(),
                          )
                        : snapshot2.data!.docs.length == 0 &&
                                snapshot1.data!.docs.length == 0
                            ? Center(
                                child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                    Rev_RoundButton(
                                      isfile: false,
                                      image: "assets/vide.png",
                                    ),
                                    Text(
                                      'Vous n\'avez pas de commande',
                                      style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                      ),
                                      textAlign: TextAlign.center,
                                    )
                                  ]))
                            : SingleChildScrollView(
                                child: ListView(
                                shrinkWrap: true,
                                scrollDirection: Axis.vertical,
                                children: [
                                  ListView.builder(
                                    scrollDirection: Axis.vertical,
                                    itemCount: snapshot1.data!.docs.length,
                                    shrinkWrap: true,
                                    itemBuilder: (context, index) {
                                      Order model1 = Order.fromJson(
                                          snapshot1.data!.docs[index].data()
                                              as Map<String, dynamic>);
                                      return Rev_OrderCard(
                                        order: model1,
                                        collection: "RMedLocal",
                                      );
                                    },
                                  ),
                                  ListView.builder(
                                    scrollDirection: Axis.vertical,
                                    itemCount: snapshot2.data!.docs.length,
                                    shrinkWrap: true,
                                    itemBuilder: (context, index) {
                                      Order model2 = Order.fromJson(
                                          snapshot2.data!.docs[index].data()
                                              as Map<String, dynamic>);
                                      return Rev_OrderCard(
                                        order: model2,
                                        collection: "RMedEtr",
                                      );
                                    },
                                  ),
                                ],
                              ));
                  },
                );
        },
      ),
    );
  }
}
