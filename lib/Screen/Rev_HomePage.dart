import 'package:flutter/material.dart';
import 'package:wasfaty_liv/Widget/Rev_Appbar.dart';
import 'package:wasfaty_liv/Widget/Rev_Drawer.dart';

import 'Order/Rev_newOrder.dart';

class Rev_HomePage extends StatefulWidget {
  String id;
  Rev_HomePage({this.id});
  @override
  _Rev_HomePageState createState() => _Rev_HomePageState();
}

class _Rev_HomePageState extends State<Rev_HomePage> {
  int page = 0;

  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();

  void openDrawer() {
    _scaffoldKey.currentState.openDrawer();
  }



 
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
          key: _scaffoldKey,
          drawer: Rev_Drawer(id: widget.id),
          appBar: Rev_Appbar(
            context,
            AppBar().preferredSize.height,
            openDrawer,
            Icon(
              Icons.menu,
              color: Theme.of(context).primaryColor,
            ),
          ),
          body: Rev_newOrder(
            where: "en livraison",
          )),
    );
  }
}
