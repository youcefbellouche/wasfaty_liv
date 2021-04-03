import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wasfaty_liv/Models/livreur.dart';
import 'package:wasfaty_liv/Widget/Rev_Button.dart';
import 'package:wasfaty_liv/Widget/Rev_TextFeild.dart';

import '../Rev_HomePage.dart';
import 'Rev_SignUp.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  // ignore: non_constant_identifier_names
  TextEditingController controller_email;

  // ignore: non_constant_identifier_names
  TextEditingController controller_pass;

  final _formKey = GlobalKey<FormState>();
  String email;
  String mdp;
  Livreur phar = new Livreur();
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
                      label: "E-mail",
                      textEditingController: controller_email,
                      mdp: false,
                      onChanged: (value) => email = value,
                      validator: (input) =>
                          !input.contains('@') ? "L'Email" : null,
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
                          SharedPreferences prefs =
                              await SharedPreferences.getInstance();
                          FirebaseFirestore.instance
                              .collection("Livreur")
                              .snapshots()
                              .listen((event) {
                            event.docs.forEach((element) {
                              Livreur model =
                                  Livreur.fromJson(element.data());
                              if (model.email == email &&
                                  model.password == mdp) {
                                if (model.suspendue) {
                                  activPop(context,
                                      "Votre compte est Suspendue !\nVeuillez nous contacter pour plus d'information");
                                } else {
                                  if (model.active) {
                                    logged = true;
                                    id = model.id;
                                    prefs.setBool('logged', logged);
                                    prefs.setString('id', id);
                                    print("in  login $id");
                                    Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => Rev_HomePage(
                                                id: id,
                                              )),
                                    );
                                  } else {
                                    activPop(context,
                                        "Votre compte n'est pas encore Vadlidé !\nVous serez contacter prochainement");
                                  }
                                }
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

  activPop(context, text) {
    return showDialog(
        context: context,
        builder: (con) {
          return Container(
            color: Colors.grey[300],
            child: SimpleDialog(
              backgroundColor: Colors.transparent,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(20.0))),
              children: [
                Center(
                  child: Text(
                    text,
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 17,
                        fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                ),
                Center(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ButtonTheme(
                      child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            RaisedButton(
                              shape: RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(20.0))),
                              color: Colors.greenAccent,
                              child: Text('ok'),
                              onPressed: () {
                                Navigator.pop(context);
                              },
                            ),
                          ]),
                    ),
                  ),
                ),
              ],
            ),
          );
        });
  }
}
