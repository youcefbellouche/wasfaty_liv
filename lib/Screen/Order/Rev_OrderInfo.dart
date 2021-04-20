import 'package:flutter/material.dart';
import 'package:wasfaty_liv/Models/order.dart';
import 'package:wasfaty_liv/Widget/Rev_Appbar.dart';

import 'Rev_CommandeInfo.dart';
import 'Rev_PharmacieInfo.dart';

class Rev_OrderInfo extends StatefulWidget {
  Order order;
  String collection;

  Rev_OrderInfo({
    this.order,
    this.collection,
  });

  @override
  _Rev_OrderInfoState createState() => _Rev_OrderInfoState();
}

class _Rev_OrderInfoState extends State<Rev_OrderInfo> {
  void ofPage() {
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
          appBar: Rev_Appbar(
            context,
            AppBar().preferredSize.height,
            ofPage,
            Icon(
              Icons.arrow_back,
              color: Theme.of(context).primaryColor,
            ),
          ),
          body: Column(
            children: [
              TabBar(
                  unselectedLabelColor: Colors.grey,
                  labelColor: Theme.of(context).primaryColor,
                  indicatorColor: Theme.of(context).accentColor,
                  tabs: [
                    Tab(
                      text: "Commande",
                    ),
                    Tab(text: "Pharmacie")
                  ]),
              Expanded(
                child: TabBarView(
                  children: [
                    Rev_CommandeInfo(
                      order: widget.order,
                      collection: widget.collection,
                    ),
                    Rev_PharmacieInfo(
                      pharmacieid: widget.order.pharmacieid,
                    ),
                  ],
                ),
              ),
            ],
          )),
    );
  }
}
