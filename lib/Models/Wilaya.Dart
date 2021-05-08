import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

import 'package:wasfaty_liv/Screen/Rev_HomePageOFF.dart';

class Wilaya {
  String name;
  String code;
  List com;

  Wilaya();

  Future<List<Wilaya>> getwilaya(BuildContext context) async {
    try {
      List<Wilaya> wilaya = <Wilaya>[];
      Wilaya wil = new Wilaya();
      var result = await http.get(Uri.parse(
          "https://europe-west1-wasfaty-patient.cloudfunctions.net/wilaya"));
      var body = convert.jsonDecode(result.body);
      for (var item in body) {
        wil = Wilaya.fromJson(item);
        wilaya.add(wil);
      }
      return wilaya;
    } catch (e) {
      showDialog(
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
                      "Problème de connexion !",
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
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(20.0))),
                                color: Colors.redAccent,
                                child: Text('ok'),
                                onPressed: () {
                                  Navigator.pop(context);
                                  Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              Rev_HomePageOFF()));
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

  Wilaya.fromJson(Map<String, dynamic> json) {
    name = json["wilaya"];
    code = json["nbr_wilaya"];
    com = json["daira"];
  }
}
