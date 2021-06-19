import 'package:flutter/material.dart';
import 'package:wasfaty_liv/Widget/Rev_Appbar.dart';
import 'package:wasfaty_liv/Widget/Rev_Drawer.dart';
import 'package:wasfaty_liv/Widget/Rev_RoundButton.dart';

import 'Rev_MedicHome.dart';
import 'Rev_OrderHome.dart';

// ignore: camel_case_types
class Rev_HomePage extends StatefulWidget {
  @override
  _Rev_HomePageState createState() => _Rev_HomePageState();
}

// ignore: camel_case_types
class _Rev_HomePageState extends State<Rev_HomePage> {
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();

  @override
  void initState() {
    super.initState();
  }

  void openDrawer() {
    _scaffoldKey.currentState!.openDrawer();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: Rev_Drawer(),
        backgroundColor: Colors.white,
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
        body: Center(
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
                      image: "assets/home/ord.png",
                      label: "RECHERCHE DE \nMEDICAMENTS\n AVEC ORDONNANCE",
                      onpressed: () async {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Rev_OrderHome()));
                      },
                    ),
                    Text(
                      'RECHERCHE DE \nMEDICAMENTS\n AVEC ORDONNANCE',
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
                        image: "assets/home/medic.png",
                        label: "RECHERCHE DE \nMEDICAMENTS",
                        onpressed: () async {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Rev_SearchMedicHome()));
                        }),
                    Text(
                      "RECHERCHE DE \nMEDICAMENT\n",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    )
                  ],
                ),
              ]),
        ));
  }
}
