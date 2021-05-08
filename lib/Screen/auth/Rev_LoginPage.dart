import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:wasfaty_liv/Functions/Auth/Rev_Auth.dart';
import 'package:wasfaty_liv/Widget/Rev_Button.dart';
import 'package:wasfaty_liv/Widget/Rev_TextFeild.dart';
import 'Rev_ForgetPass.dart';

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
  Rev_Auth auth = new Rev_Auth();
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    return loading
        ? Scaffold(
            body: Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage("assets/auth/login.png"),
                    fit: BoxFit.cover),
              ),
              child: Center(
                child: CircularProgressIndicator(),
              ),
            ),
          )
        : Scaffold(
            body: Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage("assets/auth/login.png"),
                    fit: BoxFit.cover),
              ),
              child: Center(
                child: ListView(
                  children: [
                    SizedBox(height: MediaQuery.of(context).size.height / 10),
                    SizedBox(
                        height: 200, child: Image.asset("assets/logo.png")),
                    Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          Rev_TextFeild(
                            label: "E-mail",
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
                              signin(context: context, email: email, mdp: mdp);
                            },
                            color: Theme.of(context).primaryColor,
                          ),
                          TextButton(
                              onPressed: () async {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => SignUpPage()),
                                );
                              },
                              child: Text(
                                "S'inscrire",
                              )),
                          TextButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => ForgetPage()),
                                );
                              },
                              child: Text(
                                "J'ai oublié(e) le mot de pass ?",
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

  signin({String email, String mdp, BuildContext context}) async {
    if (_formKey.currentState.validate()) {
      setState(() {
        loading = true;
      });
      var result = await auth.signIn(context: context, email: email, mdp: mdp);
      print("result $result");
      if (!result) {
        setState(() {
          loading = false;
        });
      }
    }
  }
}
