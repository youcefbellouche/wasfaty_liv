import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../Screen/Rev_ProfilePage.dart';
import 'package:wasfaty_liv/Screen/Rev_Historique.dart';
import '../Screen/Rev_HomePage.dart';
import 'package:wasfaty_liv/Functions/Auth/Rev_Auth.dart';

class Rev_Drawer extends StatefulWidget {
  @override
  _Rev_DrawerState createState() => _Rev_DrawerState();
}

class _Rev_DrawerState extends State<Rev_Drawer> {
  bool status = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getOuvert();
  }

  Future<void> getOuvert() async {
    FirebaseFirestore.instance
        .collection("Livreur")
        .doc(FirebaseAuth.instance.currentUser.uid)
        .get()
        .then((value) {
      setState(() {
        status = value.data()['disponible'];
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.465,
      child: ClipRRect(
        borderRadius: BorderRadius.only(
          bottomRight: Radius.circular(200),
        ),
        child: Container(
          child: Drawer(
            child: ListView(
              children: [
                Container(
                  padding: EdgeInsets.only(top: 10),
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                        Theme.of(context).primaryColor.withOpacity(0.7),
                        Theme.of(context).primaryColor,
                      ])),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Switch(
                        activeColor: Colors.lightGreenAccent,
                        inactiveThumbColor: Colors.redAccent,
                        value: status,
                        onChanged: (value) async {
                          print("VALUE : $value");
                          setState(() {
                            status = value;
                          });
                          await FirebaseFirestore.instance
                              .collection("Livreur")
                              .doc(FirebaseAuth.instance.currentUser.uid)
                              .update({
                            "disponible": status,
                          });
                        },
                      ),
                      SizedBox(
                        height: 9.0,
                      ),
                      Text(
                        status
                            ? 'Vous êtes disponible'
                            : "Vous n'êtes pas disponible",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 15.0,
                            fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                ),
                Container(
                  height: MediaQuery.of(context).size.height,
                  color: Theme.of(context).primaryColor,
                  padding: EdgeInsets.only(top: 20.0),
                  child: Column(children: [
                    Container(
                      color: Color(0xff1b6053),
                      child: ListTile(
                        title: Text(
                          "Acceuil",
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
                            fontStyle: FontStyle.normal,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        onTap: () {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Rev_HomePage()),
                          );
                        },
                      ),
                    ),
                    SizedBox(height: 30),
                    Container(
                      color: Color(0xff1b6053),
                      child: ListTile(
                        title: Text(
                          "Profile",
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
                            fontStyle: FontStyle.normal,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        onTap: () {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Rev_ProfilePage()),
                          );
                        },
                      ),
                    ),
                    SizedBox(height: 30),
                    Container(
                      color: Color(0xff1b6053),
                      child: ListTile(
                        title: Text(
                          "Statistique",
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
                            fontStyle: FontStyle.normal,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        onTap: () {},
                      ),
                    ),
                    SizedBox(height: 30),
                    Container(
                      color: Color(0xff1b6053),
                      child: ListTile(
                        title: Text(
                          "Historique",
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
                            fontStyle: FontStyle.normal,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        onTap: () {
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Rev_historique()));
                        },
                      ),
                    ),
                    SizedBox(height: 50),
                    Container(
                      margin: EdgeInsets.only(left: 8, right: 8),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(50)),
                      child: ListTile(
                        title: Text(
                          "Se Deconnecter",
                          style: TextStyle(
                            color: Colors.red,
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                            fontStyle: FontStyle.normal,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        onTap: () {
                          Rev_Auth().signOut(context: context);
                        },
                      ),
                    ),
                  ]),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
