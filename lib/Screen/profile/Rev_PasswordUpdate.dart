import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:wasfaty_liv/Functions/Auth/Rev_Auth.dart';
import 'package:wasfaty_liv/Widget/Rev_Appbar.dart';


import '../../Widget/Rev_Button.dart';
import '../../Widget/Rev_TextFeild.dart';
import '../Rev_HomePage.dart';

class Rev_PasswordUpdate extends StatefulWidget {
  final User currentUser;

  Rev_PasswordUpdate({this.currentUser});

  @override
  _Rev_PasswordUpdateState createState() => _Rev_PasswordUpdateState();
}

class _Rev_PasswordUpdateState extends State<Rev_PasswordUpdate> {
  TextEditingController controller_pass;
  TextEditingController controller_newPass;
  TextEditingController controller_confirmNewPass;

  final _formKey = GlobalKey<FormState>();
  String mdp;
  String newmdp;
  String confirm_newmdp;
  Rev_Auth auth = new Rev_Auth();
  void ofPage() {
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Rev_Appbar(
        context,
        AppBar().preferredSize.height,
        ofPage,
        Icon(
          Icons.arrow_back,
          color: Theme.of(context).primaryColor,
        ),
      ),
      body: Center(
        child: ListView(
          children: [
            SizedBox(height: MediaQuery.of(context).size.height / 10),
            SizedBox(height: 200, child: Image.asset("assets/logo.png")),
            Form(
              key: _formKey,
              child: Column(
                children: [
                  Rev_TextFeild(
                    label: "Ancien mot de pass",
                    textEditingController: controller_pass,
                    mdp: false,
                    onChanged: (value) => mdp = value,
                  ),
                  Rev_TextFeild(
                    label: "Noveau Mot de Passe",
                    textEditingController: controller_newPass,
                    mdp: true,
                    onChanged: (value) => newmdp = value,
                    validator: (input) => input.length < 6
                        ? "Donner un mot de passe valide"
                        : null,
                  ),
                  Rev_TextFeild(
                    label: "Confirmer le Mot de Passe",
                    textEditingController: controller_confirmNewPass,
                    mdp: true,
                    onChanged: (value) => confirm_newmdp = value,
                    validator: (input) => input.length < 6
                        ? "Donner un mot de passe valide"
                        : null,
                  ),
                  Rev_Button(
                    label: "Changer le mot de pass",
                    onpressed: () {
                      if (_formKey.currentState.validate()) {
                        auth.updateUserPassword(newmdp, mdp);
                        print(FirebaseAuth.instance.currentUser.email);
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Rev_HomePage()));
                      }
                    },
                    color: Theme.of(context).primaryColor,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
