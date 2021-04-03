import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:wasfaty_liv/Models/order.dart';
import 'package:wasfaty_liv/Widget/Card/Rev_OrderCard.dart';

class Rev_newOrder extends StatefulWidget {
  String where;
  String id;
  Rev_newOrder({this.where, this.id});

  @override
  _Rev_newOrderState createState() => _Rev_newOrderState();
}

class _Rev_newOrderState extends State<Rev_newOrder> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(bottom: 60),
      child: FutureBuilder<QuerySnapshot>(
        future: FirebaseFirestore.instance
            .collection("Commande")
            .where("livreurId", isEqualTo: widget.id)
            .where("status", isEqualTo: widget.where)
            .get(),
        builder: (context, snapshot) {
          return !snapshot.hasData
              ? Center(child: CircularProgressIndicator())
              : snapshot.data.docs.length == 0
                  ? Text('pas de commande')
                  : ListView.builder(
                      itemCount: snapshot.data.docs.length,
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        Order model =
                            Order.fromJson(snapshot.data.docs[index].data());
                        return Rev_OrderCard(
                          order: model,
                        );
                      },
                    );
        },
      ),
    );
  }
}
