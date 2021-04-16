import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

import 'package:cloud_firestore/cloud_firestore.dart';

class Wilaya {
  String name;
  String code;
  List com;

  Wilaya();
  Future<List<Wilaya>> getwilaya() async {
    List<Wilaya> wilaya = new List<Wilaya>();
    Wilaya wil = new Wilaya();
    var result = await http
        .get("https://us-central1-wasfaty-patient.cloudfunctions.net/wilaya");
    var body = convert.jsonDecode(result.body);
    for (var item in body) {
      wil = Wilaya.fromJson(item);
      wilaya.add(wil);
    }
    return wilaya;
  }

  Wilaya.fromJson(Map<String, dynamic> json) {
    name = json["wilaya"];
    code = json["nbr_wilaya"];
    com = json["daira"];
  }
}
