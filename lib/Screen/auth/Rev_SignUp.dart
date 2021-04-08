import 'dart:io';

import 'package:flutter/material.dart';

import 'package:wasfaty_liv/Functions/Auth/Rev_Auth.dart';
import 'package:wasfaty_liv/Models/livreur.dart';
import 'package:wasfaty_liv/Widget/Rev_Button.dart';
import 'package:wasfaty_liv/Widget/Rev_DropDown.dart';
import 'package:wasfaty_liv/Widget/Rev_TextFeild.dart';

class SignUpPage extends StatefulWidget {
  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  TextEditingController controller_email;
  TextEditingController controller_pass;
  TextEditingController controller_name;
  TextEditingController controller_pass_confirm;
  TextEditingController controller_phone;

  final _formKey = GlobalKey<FormState>();
  Rev_Auth auth = new Rev_Auth();

  Livreur pharmacie;
  String email;
  String name;
  String adresse;
  String mdp_confirm;
  String phone;
  String mdp;


  bool loading = false;

  bool condition = false;
  List<String> wilays = ['Alger'];
  List<String> algerDayra = [
    "Bab El Oued",
    "Baraki",
    "Bir Mourad Raïs",
    "Birtouta",
    "Bouzareah",
    "Chéraga",
    "Dar El Beïda",
    "Draria",
    "El Harrach",
    "Hussein Dey",
    "Rouïba",
    "Sidi M'Hamed",
    "Zéralda",
  ];
  String valueW;
  String dairaA;

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
            body: DecoratedBox(
              decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage("assets/auth/signup.png"),
                    fit: BoxFit.cover),
              ),
              child: Center(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      SizedBox(
                          height: 140, child: Image.asset("assets/logo.png")),
                      Form(
                          key: _formKey,
                          child: Column(
                            children: [
                              Rev_TextFeild(
                                label: "Nom Complet",
                                textEditingController: controller_name,
                                mdp: false,
                                onChanged: (value) => name = value,
                                validator: (input) =>
                                    input.isEmpty ? "Donner un nom " : null,
                                textInputType: TextInputType.name,
                              ),
                              Rev_TextFeild(
                                  label: " Numéro de tél",
                                  textEditingController: controller_phone,
                                  mdp: false,
                                  textInputType: TextInputType.phone,
                                  onChanged: (value) => phone = value,
                                  validator: (input) {
                                    if (input.isEmpty) {
                                      return "Donner un Numéro ";
                                    }
                                    if (input.length < 10 ||
                                        input.length > 10) {
                                      return "Numéro invalide";
                                    }
                                  }),
                              Rev_DropDown(
                                valuew: valueW,
                                wil: wilays,
                                onchanged: (value) {
                                  if (value == "Alger") {
                                    setState(() {
                                      valueW = value;
                                    });
                                  } else {
                                    setState(() {
                                      dairaA = null;
                                    });
                                  }
                                },
                                hint: "Wilaya",
                              ),
                              SizedBox(height: 10),
                              valueW == "Alger"
                                  ? Rev_DropDown(
                                      valuew: dairaA,
                                      wil: algerDayra,
                                      onchanged: (value) => dairaA = value,
                                      hint: "Daira",
                                    )
                                  : Container(),
                              Rev_TextFeild(
                                label: "Adresse",
                                textEditingController: controller_phone,
                                mdp: false,
                                onChanged: (value) => adresse = value,
                                validator: (input) => input.isEmpty
                                    ? "Donner une Adresse "
                                    : null,
                              ),
                              Rev_TextFeild(
                                label: "E-mail",
                                textEditingController: controller_email,
                                mdp: false,
                                textInputType: TextInputType.emailAddress,
                                onChanged: (value) => email = value,
                                validator: (input) => !input.contains('@')
                                    ? "L'Email doit être valide"
                                    : null,
                              ),
                              Rev_TextFeild(
                                label: "Mot de Passe",
                                textEditingController: controller_pass,
                                textInputType: TextInputType.visiblePassword,
                                mdp: true,
                                onChanged: (value) => mdp = value,
                                validator: (input) => input.length < 6
                                    ? "Donner un mot de passe valide"
                                    : null,
                              ),
                              Rev_TextFeild(
                                label: "Confirmer le Mot de Passe",
                                textEditingController: controller_pass,
                                mdp: true,
                                textInputType: TextInputType.visiblePassword,
                                onChanged: (value) => mdp = value,
                                validator: (input) => input.length < 6
                                    ? input != mdp
                                        ? "Votre mot de passe de confirmation est incorrecte "
                                        : null
                                    : null,
                              ),
                              CheckboxListTile(
                                title: ButtonTheme(
                                  minWidth: 5,
                                  child: TextButton(
                                    child: Text(
                                      "J'accepte les termes du Contrat",
                                    ),
                                    onPressed: () {
                                      print("contrat");
                                    },
                                  ),
                                ),
                                value: condition,
                                onChanged: (newValue) {
                                  setState(() {
                                    condition = newValue;
                                  });
                                },
                                controlAffinity: ListTileControlAffinity
                                    .leading, //  <-- leading Checkbox
                              ),
                              SizedBox(height: 5),
                              Rev_Button(
                                label: "S'inscrire",
                                onpressed: () async {
                                  if (_formKey.currentState.validate() &&
                                      condition) {
                                    signUp(
                                        wilaya: valueW,
                                        daira: dairaA,
                                        name: name,
                                        phone: phone,
                                        email: email,
                                        mdp: mdp,
                                        adresse: adresse,
                                        context: context);
                                  }
                                },
                                color: Theme.of(context).primaryColor,
                              ),
                              SizedBox(height: 20),
                            ],
                          )),
                    ],
                  ),
                ),
              ),
            ),
          );
  }

  signUp({
    String wilaya,
    String mdp,
    File file,
    String daira,
    String email,
    String adresse,
    BuildContext context,
    String name,
    String phone,
  }) async {
    setState(() {
      loading = true;
    });
    try {
      print('1 try');
      if (!await auth.signUp(
          wilaya: wilaya,
          file: file,
          daira: daira,
          name: name,
          phone: phone,
          email: email,
          mdp: mdp,
          adresse: adresse,
          context: context)) {
        setState(() {
          loading = false;
        });
        showDialog(
            context: context,
            builder: (_) => AlertDialog(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10.0))),
                  content: Text(
                    "il y a un probleme",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  actions: [
                    FlatButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: Text("ok")),
                  ],
                ));
      }
    } catch (e) {
      print(e.toString());
    }
  }


}
