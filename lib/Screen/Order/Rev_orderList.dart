import 'package:flutter/material.dart';
import 'package:wasfaty_liv/Widget/Rev_Appbar.dart';
import 'package:wasfaty_liv/Widget/Rev_Drawer.dart';

import 'Rev_newOrder.dart';

class Rev_orderList extends StatefulWidget {
  @override
  _Rev_orderListState createState() => _Rev_orderListState();
}

class _Rev_orderListState extends State<Rev_orderList> {
  int page = 0;

  void ofPage() {
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: Rev_Drawer(),
        appBar: Rev_Appbar(
          context,
          AppBar().preferredSize.height,
          ofPage,
          Icon(
            Icons.arrow_back,
            color: Theme.of(context).primaryColor,
          ),
        ) as PreferredSizeWidget?,
        body: Rev_newOrder(
          where: "en livraison",
        ));
  }
}
