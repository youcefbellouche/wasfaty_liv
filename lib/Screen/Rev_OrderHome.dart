import 'package:flutter/material.dart';
import 'package:wasfaty_liv/Widget/Rev_Appbar.dart';
import 'package:wasfaty_liv/Widget/Rev_RoundButton.dart';
import 'Historique/Rev_HistoriqueHome.dart';
import 'Order/Rev_orderList.dart';

// ignore: camel_case_types
class Rev_OrderHome extends StatefulWidget {
  @override
  _Rev_OrderHomeState createState() => _Rev_OrderHomeState();
}

// ignore: camel_case_types
class _Rev_OrderHomeState extends State<Rev_OrderHome> {
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();

  @override
  void initState() {
    super.initState();
  }

  void ofPage() {
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        key: _scaffoldKey,
        appBar: Rev_Appbar(
          context,
          AppBar().preferredSize.height,
          ofPage,
          Icon(
            Icons.arrow_back,
            color: Theme.of(context).primaryColor,
          ),
        ) as PreferredSizeWidget?,
        body: Center(
          child: Container(
            child: GridView(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 1,
                  childAspectRatio: 2,
                  mainAxisSpacing: 100,
                ),
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Rev_RoundButton(
                        isfile: false,
                        image: "assets/home/medic.png",
                        label: "RECHERCHE DE \nMEDICAMENTS\n",
                        onpressed: () async {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Rev_orderList()));
                        },
                      ),
                      Text(
                        'RECHERCHE DE \nMEDICAMENTS\n',
                        style: TextStyle(
                          fontSize: 18,
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
                          image: "assets/medic/listMedic.png",
                          label: "HISTORIQUE",
                          onpressed: () async {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Rev_HistoriqueHome(
                                          collectionLocal: 'Commande',
                                          collectionEtr: 'Commande_etr',
                                        )));
                          }),
                      Text(
                        "HISTORIQUE",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      )
                    ],
                  ),
                ]),
          ),
        ));
  }
}
