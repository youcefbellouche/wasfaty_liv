import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wasfaty_liv/Screen/auth/Rev_LoginPage.dart';
import '../Screen/Rev_ProfilePage.dart';
import 'package:wasfaty_liv/Screen/Rev_Historique.dart';
import '../Screen/Rev_HomePage.dart';

class Rev_Drawer extends StatelessWidget {
  Rev_Drawer({this.id});
  final String id;

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
                  height: MediaQuery.of(context).size.height,
                  color: Theme.of(context).primaryColor,
                  padding: EdgeInsets.only(top: 100.0),
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
                                builder: (context) =>
                                    Rev_HomePage(id: this.id)),
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
                          print(id);
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Rev_ProfilePage(
                                    )),
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
                                  builder: (context) =>
                                      Rev_Historique(id: id)));
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
                        onTap: () async {
                          SharedPreferences prefs =
                              await SharedPreferences.getInstance();
                          prefs.clear();
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => LoginPage()));
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
