import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../../Models/livreur.dart';
import '../../Screen/Rev_HomePage.dart';

class Rev_Auth {
  Future<void> updatePassword(String oldPass, String newPass, String id) async {
    print("youcef $id");
    var result =
        await FirebaseFirestore.instance.collection("Livreur").doc(id).get();
    String tmp = result.get("password");
    if (tmp == oldPass) {
      await FirebaseFirestore.instance.collection("Livreur").doc(id).update({
        "password": newPass,
      });
    } else {
      print("mdp galet");
    }
  }

  void updatePhoneNum({String phone, String id}) async {
    await FirebaseFirestore.instance
        .collection("Livreur")
        .doc(id)
        .update({'phone': phone});
    print("mchat");
  }

  Future<String> getPhone(String id) async {
    String phone;
    var result =
        await FirebaseFirestore.instance.collection("Livreur").doc(id).get();
    phone = result["phone"];
    return phone;
  }

  Future<void> signUp(Livreur livreur, BuildContext context) async {
    String id;
    await FirebaseFirestore.instance.collection("Livreur").add({
      "name": livreur.name,
      "phone": livreur.phone,
      "email": livreur.email,
      "password": livreur.password,
      "adresse": livreur.adresse,
      "active": false,
      "ouvert": false,
    }).then((value) async {
      id = value.id;
      await FirebaseFirestore.instance
          .collection("Livreur")
          .doc(value.id)
          .update({
        'id': value.id,
      });
    });
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => Rev_HomePage(id: id)),
    );
  }
}
