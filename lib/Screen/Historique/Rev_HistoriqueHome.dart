import 'package:flutter/material.dart';
import 'package:wasfaty_liv/Widget/Rev_Appbar.dart';
import 'package:wasfaty_liv/Widget/Rev_Drawer.dart';
import 'package:wasfaty_liv/Widget/Rev_RoundButton.dart';

import 'Rev_Historique.dart';

class Rev_HistoriqueHome extends StatefulWidget {
  @override
  _Rev_HistoriqueHomeState createState() => _Rev_HistoriqueHomeState();
}

class _Rev_HistoriqueHomeState extends State<Rev_HistoriqueHome> {
  void openDrawer() {
    _scaffoldKey.currentState!.openDrawer();
  }

  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Rev_Drawer(),
      key: _scaffoldKey,
      appBar: Rev_Appbar(
        context,
        AppBar().preferredSize.height,
        openDrawer,
        Icon(
          Icons.menu,
          color: Theme.of(context).primaryColor,
        ),
      ) as PreferredSizeWidget?,
      body: Container(
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Rev_RoundButton(
                isfile: false,
                image: "assets/home/local.png",
                label: "Commande en ligne",
                onpressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (cotnext) =>
                              Rev_historique(collection: "Commande")));
                },
              ),
              Text(
                'LES COMMANDE\nEN LIGNE',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              )
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Rev_RoundButton(
                  isfile: false,
                  image: "assets/home/world.png",
                  label: "Commande a L'Étranger",
                  onpressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (cotnext) =>
                                Rev_historique(collection: "Commande_etr")));
                  }),
              Text(
                "LES COMMANDE\nA L'ETRANGER",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              )
            ],
          ),
        ],
      )),
    );
  }
}
