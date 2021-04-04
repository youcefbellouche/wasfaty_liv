import 'package:flutter/material.dart';
import 'package:wasfaty_liv/Widget/Rev_Appbar.dart';
import 'package:wasfaty_liv/Widget/Rev_Drawer.dart';

import 'Order/Rev_newOrder.dart';

class Rev_Historique extends StatefulWidget {
  String id;
  Rev_Historique({this.id});
  @override
  _Rev_HistoriqueState createState() => _Rev_HistoriqueState();
}

class _Rev_HistoriqueState extends State<Rev_Historique> {
  int page = 0;

  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();

  void openDrawer() {
    _scaffoldKey.currentState.openDrawer();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print("in historique ${widget.id}");
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
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
          bottomSheet: Container(
            decoration: BoxDecoration(
                border: Border.all(
                    width: 3.0, color: Theme.of(context).accentColor)),
            child: TabBar(
                unselectedLabelColor: Colors.black,
                labelColor: Theme.of(context).primaryColor,
                indicatorColor: Theme.of(context).accentColor,
                tabs: [
                  Tab(
                    text: "terminer",
                  ),
                  Tab(text: "annuler"),
                ]),
          ),
          body: TabBarView(
            children: [
              Rev_newOrder(
                where: "terminer",
              ),
              Rev_newOrder(
                where: "annuler",
              ),
            ],
          )),
    );
  }
}
