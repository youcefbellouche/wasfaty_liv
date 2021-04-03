import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../Models/livreur.dart';
import '../../Screen/Rev_HomePage.dart';
import '../../Widget/Rev_Button.dart';
import '../../Widget/Rev_TextFeild.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'Rev_SignUp.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController controller_email;

  TextEditingController controller_pass;

  final _formKey = GlobalKey<FormState>();

  String email;

  String mdp;

  Livreur livreur = new Livreur();

  bool co = false;

  String id;
  bool logged = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage("assets/auth/login.png"), fit: BoxFit.cover),
        ),
        child: Center(
          child: ListView(
            children: [
              SizedBox(height: MediaQuery.of(context).size.height / 10),
              SizedBox(height: 200, child: Image.asset("assets/logo.png")),
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    Rev_TextFeild(
                      label: "E-mail ou Numéro de tél",
                      textEditingController: controller_email,
                      mdp: false,
                      onChanged: (value) => email = value,
                      validator: (input) => !input.contains('@')
                          ? "L'Email doit être valide"
                          : null,
                    ),
                    Rev_TextFeild(
                      label: "Mot de Passe",
                      textEditingController: controller_pass,
                      mdp: true,
                      onChanged: (value) => mdp = value,
                      validator: (input) => input.length < 6
                          ? "Donner un mot de passe valide"
                          : null,
                    ),
                    Rev_Button(
                      label: "Se Connecter",
                      onpressed: () async {
                        if (_formKey.currentState.validate()) {
                          await FirebaseFirestore.instance
                              .collection("Livreur")
                              .snapshots()
                              .listen((event) {
                            event.docs.forEach((element) async {
                              if (element.data()['email'].toString() == email &&
                                  element.data()['password'].toString() ==
                                      mdp) {
                                SharedPreferences prefs =
                                    await SharedPreferences.getInstance();
                                logged = true;
                                id = element.data()['id'];
                                await prefs.setBool('logged', logged);
                                await prefs.setString('uid', id);
                                print(element.data()["id"]);
                                FirebaseFirestore.instance
                                    .collection("Livreur")
                                    .doc(element.data()['id'])
                                    .update({
                                  "ouvert": true,
                                });
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => Rev_HomePage(
                                            id: id,
                                          )),
                                );
                              }
                            });
                          });
                        }
                      },
                      color: Theme.of(context).primaryColor,
                    ),
                    TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => SignUpPage()),
                          );
                        },
                        child: Text(
                          "S'inscrire",
                        ))
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
