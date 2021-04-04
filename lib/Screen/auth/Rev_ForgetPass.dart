import 'package:connectivity/connectivity.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:wasfaty_liv/Functions/Auth/Rev_Auth.dart';
import 'package:wasfaty_liv/Widget/Rev_Button.dart';
import 'package:wasfaty_liv/Widget/Rev_TextFeild.dart';

class ForgetPage extends StatefulWidget {
  @override
  _ForgetPageState createState() => _ForgetPageState();
}

class _ForgetPageState extends State<ForgetPage> {
  TextEditingController controller_email;
  final _formKey = GlobalKey<FormState>();
  String email;
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
                          Text("Donner l'email de votre compte"),
                          Rev_TextFeild(
                            label: "E-mail",
                            textEditingController: controller_email,
                            mdp: false,
                            onChanged: (value) => email = value,
                            validator: (input) => !input.contains('@')
                                ? "L'Email doit être valide"
                                : null,
                          ),
                          Rev_Button(
                            label: "Confirmer",
                            onpressed: () async {
                              auth.passwordReset(
                                  email: email, context: context);
                            },
                            color: Theme.of(context).primaryColor,
                          ),
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
