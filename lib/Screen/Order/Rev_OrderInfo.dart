import 'package:flutter/material.dart';
import 'package:wasfaty_liv/Models/order.dart';
import 'package:wasfaty_liv/Widget/Rev_Appbar.dart';

import 'Rev_CommandeInfo.dart';
import 'Rev_PharmacieInfo.dart';


class Rev_OrderInfo extends StatefulWidget {
  Order order;

  Rev_OrderInfo({
    this.order,
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
          bottomSheet: Container(
            decoration: BoxDecoration(
                border: Border.all(
                    width: 2.0, color: Theme.of(context).accentColor)),
            child: TabBar(
                unselectedLabelColor: Colors.grey,
                labelColor: Theme.of(context).primaryColor,
                indicatorColor: Theme.of(context).accentColor,
                tabs: [
                  Tab(
                    text: "Commande",
                  ),
                  Tab(text: "Livreur")
                ]),
          ),
          body: TabBarView(
            children: [
              Rev_CommandeInfo(
                order: widget.order,
                collection: "Commande",
              ),
              Rev_PharmacieInfo(
                pharmacieid: widget.order.pharmacieid,
              ),
            ],
          )),
    );
  }
}
