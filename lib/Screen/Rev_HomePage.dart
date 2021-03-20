import 'package:flutter/material.dart';
import '../Widget/Rev_Appbar.dart';
import '../Widget/Rev_Drawer.dart';
import '../Widget/Rev_RoundButton.dart';

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
    print("azeaz ${widget.id}");
    return Scaffold(
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
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.09,
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Rev_RoundButton(
                        isfile: false,
                        image: page == 0
                            ? "assets/home/nouvelles/new_0.png"
                            : "assets/home/nouvelles/new_1.png",
                        label: "ALARM",
                        onpressed: () {
                          setState(() {
                            page = 0;
                          });
                        }),
                    Text(
                      "Nouvelles",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Rev_RoundButton(
                        isfile: false,
                        image: page == 1
                            ? "assets/home/traitement/traitement_0.png"
                            : "assets/home/traitement/traitement_1.png",
                        label: "Commande a L'Étranger",
                        onpressed: () {
                          setState(() {
                            page = 1;
                          });
                        }),
                    Text(
                      "Valide",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ],
            ),
            page == 0
                ? Rev_newOrder(
                    id: widget.id,
                    where: "en traitement",
                  )
                : Rev_newOrder(
                    id: widget.id,
                    where: "valide",
                  )
          ],
        ),
      ),
    );
  }
}
