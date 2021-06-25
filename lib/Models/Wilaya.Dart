import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async' show Future;
import 'dart:convert' as convert;
import 'package:flutter/services.dart' show rootBundle;
import 'package:patient/Screen/Rev_HomePageOFF.dart';

class Wilaya {
  late String name;
  late String code;
  late List com = [];

  Wilaya();

  Future<List<Wilaya>> getwilaya() async {
    List<Wilaya> wilaya = <Wilaya>[];
    Wilaya wil = new Wilaya();
    var jsonText = await rootBundle.loadString('assets/wilaya.json');
    var body = convert.jsonDecode(jsonText);

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
