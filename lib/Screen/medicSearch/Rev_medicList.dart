import 'package:flutter/material.dart';
import 'package:wasfaty_liv/Widget/Rev_Appbar.dart';
import 'package:wasfaty_liv/Widget/Rev_Drawer.dart';

import 'Rev_newOrderMedic.dart';

class Rev_medicList extends StatefulWidget {
  @override
  _Rev_medicListState createState() => _Rev_medicListState();
}

class _Rev_medicListState extends State<Rev_medicList> {
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
        body: Rev_newOrderMedic(
          where: "en livraison",
        ));
  }
}
