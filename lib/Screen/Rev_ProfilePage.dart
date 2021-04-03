import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wasfaty_liv/Screen/auth/Rev_LoginPage.dart';

import '../Functions/Auth/Rev_Auth.dart';
import '../Screen/profile/Rev_phoneUpdate.dart';

import '../Widget/Rev_Appbar.dart';
import '../Widget/Rev_Drawer.dart';
import '../Widget/Rev_RoundButton.dart';
import './profile/Rev_PasswordUpdate.dart';

class Rev_ProfilePage extends StatefulWidget {
  @override
  _Rev_ProfilePageState createState() => _Rev_ProfilePageState();
  final String id;
  Rev_ProfilePage({this.id});
}

class _Rev_ProfilePageState extends State<Rev_ProfilePage> {
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();
  void openDrawer() {
    _scaffoldKey.currentState.openDrawer();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      drawer: Rev_Drawer(),
      appBar: Rev_Appbar(
        context,
        AppBar().preferredSize.height,
        openDrawer,
        Icon(
          Icons.menu,
          color: Theme.of(context).primaryColor,
        ),
      ),
      body: Container(
        child: GridView(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 0.8,
          ),
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Rev_RoundButton(
                  isfile: false,
                  image: "assets/profile/pass.png",
                  label: "Changer Votre Mot de Passe",
                  onpressed: () async {
                    print(this.widget.id);
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => Rev_PasswordUpdate(
                                  id: this.widget.id,
                                )));
                  },
                ),
                Text(
                  'CHANGER VOTRE MOT DE PASSE',
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
                  image: "assets/profile/adresse.png",
                  label: "Changer votre Addresse",
                  onpressed: () async {},
                ),
                Text(
                  'CHANGER VOTRE ADDRESSE',
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
                  image: "assets/profile/phone.png",
                  label: "CHANGER VOTRE NUMERO DE TELEPHONE",
                  onpressed: () async {
                    String oldphone;
                    oldphone = await Rev_Auth().getPhone(this.widget.id);
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => Rev_phoneUpdate(
                                  id: this.widget.id,
                                  oldphone: oldphone,
                                )));
                  },
                ),
                Text(
                  'CHANGER VOTRE NUM DE TELEPHONE',
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
                  image: "assets/profile/logout.png",
                  label: "SE DECONNECTER",
                  onpressed: () async {
                    SharedPreferences prefs =
                        await SharedPreferences.getInstance();
                    prefs.clear();
                    Navigator.pushReplacement(context,
                        MaterialPageRoute(builder: (context) => LoginPage()));
                  },
                ),
                Text(
                  'SE DECONNECTER',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
