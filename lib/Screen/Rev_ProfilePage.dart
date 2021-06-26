import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:wasfaty_liv/Functions/Auth/Rev_Auth.dart';
import 'package:wasfaty_liv/Widget/Rev_Appbar.dart';
import 'package:wasfaty_liv/Widget/Rev_Drawer.dart';
import 'package:wasfaty_liv/Widget/Rev_RoundButton.dart';

import 'Profile/Rev_Passwordupdate.dart';
import 'Profile/Rev_ProfileInfo.dart';

class Rev_ProfilePage extends StatelessWidget {
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();
  String uid = FirebaseAuth.instance.currentUser!.uid;
  User? currentUser = FirebaseAuth.instance.currentUser;

  void openDrawer() {
    _scaffoldKey.currentState!.openDrawer();
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
      ) as PreferredSizeWidget?,
      body: Center(
        child: Container(
          child: GridView(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 1,
              childAspectRatio: 2,
              mainAxisSpacing: 30,
            ),
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Rev_RoundButton(
                    isfile: false,
                    image: "assets/profile/phone.png",
                    label: "Profile",
                    onpressed: () async {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => Rev_ProfileInfo(
                                    uid: uid,
                                  )));
                    },
                  ),
                  Text(
                    'PROFILE',
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
                    image: "assets/profile/pass.png",
                    label: "Changer Votre Mot de Passe",
                    onpressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => Rev_PasswordUpdate(
                                    currentUser: currentUser,
                                  )));
                    },
                  ),
                  Text(
                    'CHANGER VOTRE\nMOT DE PASSE',
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
                    onpressed: () {
                      Rev_Auth().signOut(context: context);
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
      ),
    );
  }
}
