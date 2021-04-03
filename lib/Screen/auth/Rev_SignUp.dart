import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:wasfaty_liv/Models/livreur.dart';
import 'package:wasfaty_liv/Widget/Rev_Button.dart';
import 'package:wasfaty_liv/Widget/Rev_DropDown.dart';
import 'package:wasfaty_liv/Widget/Rev_RoundButton.dart';
import 'package:wasfaty_liv/Widget/Rev_TextFeild.dart';
import 'package:image_picker/image_picker.dart';

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

  Livreur pharmacie;
  String email;
  String name;
  String adresse;
  String mdp_confirm;
  String phone;
  String mdp;

  File _imageFileO = null;
  bool isfileO = false;
  String imageFileName;

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
                Rev_RoundButton(
                  isfile: isfileO,
                  file: _imageFileO,
                  image: "assets/form/takepic.png",
                  label: "Photo de Profile",
                  onpressed: () {
                    print("Prendre en photo une ordonnance");
                    takeImage(context);
                  },
                  onpressedP: () {
                    verifyImage(context, _imageFileO, false);
                  },
                ),
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
                              if (input.length < 10 || input.length > 10) {
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
                          validator: (input) =>
                              input.isEmpty ? "Donner une Adresse " : null,
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
                            if (_formKey.currentState.validate() && condition) {
                              await FirebaseFirestore.instance
                                  .collection("Livreur")
                                  .add({}).then((value) async {
                                imageFileName =
                                    "profile_${DateTime.now().millisecondsSinceEpoch}.jpg";
                                Reference storageReferenceC =
                                    FirebaseStorage.instance.ref().child(
                                        'LivreurProfile/${value.id}/$imageFileName');
                                print(value.id);
                                storageReferenceC.putFile(_imageFileO).then(
                                    (valueP) => valueP.ref
                                            .getDownloadURL()
                                            .then((valueURL) async {
                                          await FirebaseFirestore.instance
                                              .collection("Livreur")
                                              .doc(value.id)
                                              .set({
                                            'id': value.id,
                                            "profile": valueURL,
                                            "wilaya": valueW,
                                            "daira": dairaA,
                                            "active": false,
                                            "suspendue": false,
                                            "name": name,
                                            "phone": phone,
                                            "email": email,
                                            "password": mdp,
                                            "adresse": adresse,
                                          });
                                        }));
                              });
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

  takeImage(context) {
    return showDialog(
        context: context,
        builder: (con) {
          return SimpleDialog(
            title: Text('Photo de Profile',
                style: TextStyle(
                    color: Theme.of(context).primaryColor,
                    fontWeight: FontWeight.bold)),
            children: [
              SimpleDialogOption(
                child: Text(
                  "Utiliser l'appareil Photo ",
                  style: TextStyle(
                    color: Theme.of(context).accentColor,
                  ),
                ),
                onPressed: () {
                  pickImageWithCameraO(context);
                },
              ),
              SimpleDialogOption(
                child: Text(
                  "Prendre Une Photo dans la Galerie",
                  style: TextStyle(
                    color: Theme.of(context).accentColor,
                  ),
                ),
                onPressed: () {
                  pickImageWithGallery(context);
                },
              ),
              SimpleDialogOption(
                  child: Text(
                    "Annuler ",
                    style: TextStyle(color: Colors.redAccent),
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  })
            ],
          );
        });
  }

  Future pickImageWithGallery(
    BuildContext context,
  ) async {
    final pickedFile = await ImagePicker.pickImage(source: ImageSource.gallery);

    setState(() {
      _imageFileO = File(pickedFile.path);
    });
    isfileO = true;
    Navigator.pop(context);
  }

  Future pickImageWithCameraO(
    BuildContext context,
  ) async {
    final pickedFile = await ImagePicker.pickImage(source: ImageSource.camera);

    setState(() {
      _imageFileO = File(pickedFile.path);
    });
    isfileO = true;
    Navigator.pop(context);
  }

  verifyImage(context, file, chifa) {
    return showDialog(
        context: context,
        builder: (con) {
          return SimpleDialog(
            backgroundColor: Colors.transparent,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(20.0))),
            children: [
              Container(
                  decoration: BoxDecoration(
                      border: Border.all(width: 2, color: Colors.grey)),
                  child: Image.file(file, fit: BoxFit.cover)),
              Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    RaisedButton(
                      shape: RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.all(Radius.circular(20.0))),
                      color: Colors.redAccent,
                      child: Text(
                        'Annuler',
                        style: TextStyle(color: Colors.white),
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                    RaisedButton(
                      shape: RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.all(Radius.circular(20.0))),
                      color: Colors.green,
                      child: Text(
                        'Changer de photo',
                        style: TextStyle(color: Colors.white),
                      ),
                      onPressed: () {
                        takeImage(context);

                        Navigator.pop(context);
                      },
                    ),
                  ]),
            ],
          );
        });
  }
}
