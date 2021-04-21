import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:wasfaty_liv/Screen/Rev_ProfilePage.dart';
import 'package:wasfaty_liv/Screen/auth/Rev_LoginPage.dart';
import '../../Screen/Rev_HomePage.dart';

class Rev_Auth {
  FirebaseMessaging fcm = FirebaseMessaging();

  Future<bool> validateCurrentPassword(String pass) async {
    return await validatePassword(pass);
  }

  void updateUserPassword(String newPass, String oldPass) async {
    var valide = await validateCurrentPassword(oldPass);
    if (valide == false) {
      return;
    }
    var firebaseuser = FirebaseAuth.instance.currentUser;
    firebaseuser.updatePassword(newPass);
  }

  Future<bool> validatePassword(String pass) async {
    var firebaseUser = FirebaseAuth.instance.currentUser;
    var credential =
        EmailAuthProvider.credential(email: firebaseUser.email, password: pass);
    try {
      var result = await firebaseUser.reauthenticateWithCredential(credential);
      return result.user != null;
    } catch (e) {
      print(e);
      return false;
    }
  }

  void signOut({BuildContext context}) async {
    await FirebaseFirestore.instance
        .collection("Livreur")
        .doc(FirebaseAuth.instance.currentUser.uid)
        .update({
      "disponible": false,
    });
    FirebaseAuth.instance.signOut();
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => LoginPage()));
  }

  void updatePhoneNum({String phone, String uid, BuildContext context}) async {
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

  Future<String> getPhone() async {
    String phone;
    var result = await FirebaseFirestore.instance
        .collection("Livreur")
        .doc(FirebaseAuth.instance.currentUser.uid)
        .get();
    phone = result["phone"];
    return phone;
  }

  passwordReset({BuildContext context, String email}) {
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

  Future<bool> signIn({String email, String mdp, BuildContext context}) async {
    try {
      String token = await fcm.getToken();
      var result = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: mdp);
      var type = await FirebaseFirestore.instance
          .collection("Livreur")
          .doc(result.user.uid)
          .get();
      if (result != null) {
        await FirebaseFirestore.instance
            .collection("Patients")
            .doc(result.user.uid)
            .update({"token": token});

        if (type.data()["type"] == "Livreur") {
          if (type.data()["suspendue"]) {
            activPop(context,
                "Votre compte est Suspendue !\nVeuillez nous contacter pour plus d'information");
            return false;
          } else {
            if (type.data()["active"]) {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => Rev_HomePage()),
              );
              return true;
            } else {
              activPop(context,
                  "Votre compte n'est pas encore Vadlider !\nVous serez contacter prochainement");
              return false;
            }
          }
        } else {
          signOut(context: context);
          return false;
        }
      }
    } catch (e) {
      showDialog(
          context: context,
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
  }

  Future<bool> signUp(
      {String wilaya,
      String daira,
      String name,
      String phone,
      String email,
      String mdp,
      String adresse,
      File file,
      BuildContext context}) async {
    User fuser;
    try {
      var result = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: mdp)
          .then((_auth) {
        fuser = _auth.user;
        _auth.user.updateProfile(displayName: name);
      });
      String token = await fcm.getToken();

      await FirebaseFirestore.instance
          .collection("Livreur")
          .doc(fuser.uid)
          .set({
        "type": "Livreur",
        "id": fuser.uid,
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
