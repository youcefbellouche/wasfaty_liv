import 'package:flutter/material.dart';
import '../../Functions/Auth/Rev_Auth.dart';
import '../../Models/livreur.dart';
import '../../Widget/Rev_Button.dart';
import '../../Widget/Rev_TextFeild.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

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

  Livreur livreur;
  Rev_Auth signUp;
  String email;
  String name;
  String adresse;
  String mdp_confirm;
  String phone;
  String mdp;

  bool condition = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: DecoratedBox(
        decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage("assets/auth/signup.png"), fit: BoxFit.cover),
        ),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: 140, child: Image.asset("assets/logo.png")),
                Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        Rev_TextFeild(
                          label: "Nom Complet",
                          textEditingController: controller_name,
                          mdp: false,
                          onChanged: (value) => name = value,
                          // validator: (input) =>
                          //     input.isEmpty ? "Donner un nom " : null,
                          textInputType: TextInputType.name,
                        ),
                        Rev_TextFeild(
                          label: " Numéro de tél",
                          textEditingController: controller_phone,
                          mdp: false,
                          textInputType: TextInputType.phone,
                          onChanged: (value) => phone = value,
                          // validator: (input) =>
                          //     input.isEmpty ? "Donner un Numéro " : null,
                        ),
                        Rev_TextFeild(
                          label: "Adresse",
                          textEditingController: controller_phone,
                          mdp: false,
                          onChanged: (value) => adresse = value,
                          // validator: (input) =>
                          //     input.isEmpty ? "Donner une Adresse " : null,
                        ),
                        Rev_TextFeild(
                          label: "E-mail",
                          textEditingController: controller_email,
                          mdp: false,
                          textInputType: TextInputType.emailAddress,
                          onChanged: (value) => email = value,
                          // validator: (input) => !input.contains('@')
                          //     ? "L'Email doit être valide"
                          //     : null,
                        ),
                        Rev_TextFeild(
                          label: "Mot de Passe",
                          textEditingController: controller_pass,
                          textInputType: TextInputType.visiblePassword,
                          mdp: true,
                          onChanged: (value) => mdp = value,
                          // validator: (input) => input.length < 6
                          //     ? "Donner un mot de passe valide"
                          //     : null,
                        ),
                        Rev_TextFeild(
                          label: "Confirmer le Mot de Passe",
                          textEditingController: controller_pass,
                          mdp: true,
                          textInputType: TextInputType.visiblePassword,
                          onChanged: (value) => mdp = value,
                          // validator: (input) => input.length < 6
                          //     ? "Donner un mot de passe valide"
                          //     : null,
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
                            livreur = new Livreur(
                                name: name,
                                phone: phone,
                                adresse: adresse,
                                email: email,
                                password: mdp);
                            if (_formKey.currentState.validate() && condition) {
                              print(Livreur);
                              await Rev_Auth().signUp(livreur, context);
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
}
