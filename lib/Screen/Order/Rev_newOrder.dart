import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:wasfaty_liv/Models/order.dart';
import 'package:wasfaty_liv/Widget/Card/Rev_OrderCard.dart';

class Rev_newOrder extends StatefulWidget {
  String where;
  Rev_newOrder({this.where});

  @override
  _Rev_newOrderState createState() => _Rev_newOrderState();
}

class _Rev_newOrderState extends State<Rev_newOrder> {
  


  Order model;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(bottom: 60),
      child: FutureBuilder<QuerySnapshot>(
        future: FirebaseFirestore.instance
            .collection("Commande")
            .where("livreurId", isEqualTo: FirebaseAuth.instance.currentUser.uid)
            .where("status", isEqualTo: widget.where)
            .get(),
        builder: (context, snapshot1) {
          return !snapshot1.hasData
              ? Center(child: CircularProgressIndicator())
              : FutureBuilder<QuerySnapshot>(
                  future: FirebaseFirestore.instance
                      .collection("Commande_etr")
                      .where("livreurId", isEqualTo: FirebaseAuth.instance.currentUser.uid)
                      .where("status", isEqualTo: widget.where)
                      .get(),
                  builder: (cotnext, snapshot2) {
                    return !snapshot2.hasData
                        ? Center(
                            child: CircularProgressIndicator(),
                          )
                        : snapshot2.data.docs.length == 0 &&
                                snapshot1.data.docs.length == 0
                            ? Text('pas de commande')
                            : SingleChildScrollView(
                                child: ListView(
                                shrinkWrap: true,
                                scrollDirection: Axis.vertical,
                                children: [

                                  ListView.builder(
                                    scrollDirection: Axis.vertical,
                                    itemCount: snapshot1.data.docs.length,
                                    shrinkWrap: true,
                                    itemBuilder: (context, index) {
                                      Order model1 = Order.fromJson(
                                          snapshot1.data.docs[index].data());
                                      return Rev_OrderCard(
                                        order: model1,
                                        collection: "Commande",
                                      );
                                    },
                                  ),
                                  ListView.builder(
                                    scrollDirection: Axis.vertical,
                                    itemCount: snapshot2.data.docs.length,
                                    shrinkWrap: true,
                                    itemBuilder: (context, index) {
                                      Order model2 = Order.fromJson(
                                          snapshot2.data.docs[index].data());
                                      return Rev_OrderCard(
                                        order: model2,
                                        collection: "Commande_etr",
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
