import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:wasfaty_liv/Screen/Rev_ProfilePage.dart';
import 'package:wasfaty_liv/Screen/auth/Rev_LoginPage.dart';
import 'package:wasfaty_liv/Screen/auth/Rev_VerifierMail.dart';
import '../../Screen/Rev_HomePage.dart';

class Rev_Auth {
  FirebaseMessaging fcm = FirebaseMessaging.instance;

  Future<bool> validateCurrentPassword(String pass) async {
    return await validatePassword(pass);
  }

  void updateUserPassword(String? newPass, String oldPass) async {
    var valide = await validateCurrentPassword(oldPass);
    if (valide == false) {
      return;
    }
    var firebaseuser = FirebaseAuth.instance.currentUser!;
    firebaseuser.updatePassword(newPass!);
  }

  Future<bool> validatePassword(String pass) async {
    var firebaseUser = FirebaseAuth.instance.currentUser!;
    var credential = EmailAuthProvider.credential(
        email: firebaseUser.email!, password: pass);
    try {
      var result = await firebaseUser.reauthenticateWithCredential(credential);
      return result.user != null;
    } catch (e) {
      print(e);
      return false;
    }
  }

  void signOut({required BuildContext context}) async {
    await FirebaseFirestore.instance
        .collection("Livreur")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .update({
      "disponible": false,
    });
    FirebaseAuth.instance.signOut();
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => LoginPage()));
  }

  void updatePhoneNum(
      {String? phone, String? uid, required BuildContext context}) async {
    await FirebaseFirestore.instance
        .collection("Livreur")
        .doc(uid)
        .update({'tel': phone});
    showDialog(
        barrierDismissible: false,
        useSafeArea: false,
        useRootNavigator: false,
        context: context,
        builder: (_) => AlertDialog(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10.0))),
              content: Center(
                  widthFactor: 20,
                  heightFactor: 2,
                  child: Text(
                    "Le numero est changer",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  )),
              actions: [
                FlatButton(
                    onPressed: () {
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => Rev_ProfilePage()));
                    },
                    child: Text("ok")),
              ],
            ));
  }

  Future<String?> getPhone() async {
    String? phone;
    var result = await FirebaseFirestore.instance
        .collection("Livreur")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get();
    phone = result["phone"];
    return phone;
  }

  passwordReset({required BuildContext context, required String email}) {
    FirebaseAuth.instance.sendPasswordResetEmail(email: email);
    showDialog(
        useSafeArea: false,
        barrierDismissible: false,
        context: context,
        builder: (_) => AlertDialog(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10.0))),
              content: Center(
                  widthFactor: 20,
                  heightFactor: 2,
                  child: Text(
                    "Email envoyer",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  )),
              actions: [
                FlatButton(
                    onPressed: () {
                      Navigator.pushReplacement(context,
                          MaterialPageRoute(builder: (context) => LoginPage()));
                    },
                    child: Text("ok")),
              ],
            ));
  }

  Future<bool> signIn(
      {required String email,
      required String mdp,
      BuildContext? context}) async {
    try {
      String? token = await FirebaseMessaging.instance.getToken();
      var result = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: mdp);
      print("Singin result $result");
      var type = await FirebaseFirestore.instance
          .collection("Livreur")
          .doc(result.user!.uid)
          .get();
      if (result != null) {
        if (type.data()!["type"] == "Livreur") {
          await FirebaseFirestore.instance
              .collection("Livreur")
              .doc(result.user!.uid)
              .update({"token": token});
          if (type.data()!["suspendue"]) {
            FirebaseAuth.instance.signOut();
            activPop(context,
                "Votre compte est Suspendue !\nVeuillez nous contacter pour plus d'information");

            return false;
          } else {
            if (result.user!.emailVerified) {
              if (type.data()!["active"]) {
                Navigator.pushReplacement(
                  context!,
                  MaterialPageRoute(builder: (context) => Rev_HomePage()),
                );
                return true;
              } else {
                FirebaseAuth.instance.signOut();
                activPop(context,
                    "Votre compte n'est pas encore Vadlider !\nVous serez contacter prochainement");
                return false;
              }
            } else {
              Navigator.pushReplacement(
                context!,
                MaterialPageRoute(builder: (context) => Rev_VerifierMail()),
              );
              return true;
            }
          }
        } else {
          FirebaseAuth.instance.signOut();
          return false;
        }
      }
    } catch (e) {
      print("errore $e");
      showDialog(
          context: context!,
          builder: (_) => AlertDialog(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10.0))),
                content: Text(
                  "Email ou Mot de pass est incorrect",
                  textAlign: TextAlign.center,
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
      return false;
    }
    return false;
  }

  Future<bool> signUp(
      {String? wilaya,
      String? daira,
      String? name,
      String? phone,
      required String email,
      required String mdp,
      String? adresse,
      File? file,
      required BuildContext context}) async {
    User? fuser;
    try {
      dynamic result = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: mdp)
          .then((_auth) {
        fuser = _auth.user;
        _auth.user!.updateProfile(displayName: name);
      });
      String? token = await fcm.getToken();

      await FirebaseFirestore.instance
          .collection("Livreur")
          .doc(fuser!.uid)
          .set({
        "type": "Livreur",
        "id": fuser!.uid,
        "wilaya": wilaya,
        "disponible": false,
        "daira": daira,
        "active": false,
        "suspendue": false,
        "name": name,
        "Time": DateTime.now().millisecondsSinceEpoch,
        "phone": phone,
        "email": email,
        "adresse": adresse,
        "token": token
      });

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => LoginPage()),
      );
      return true;
    } catch (e) {
      if (e.toString().contains("[firebsa_auth/email-already-in-use]")) {
        showDialog(
            context: context,
            builder: (_) => AlertDialog(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10.0))),
                  content: Text(
                    "L'email que vous avez utilliser\nest deja utilliser dans une autre application Wasfaty",
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
      } else {
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
      return false;
    }
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
