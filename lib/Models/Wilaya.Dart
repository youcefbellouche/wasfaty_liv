import 'package:cloud_firestore/cloud_firestore.dart';

class Wilaya {
  String name;
  String code;
  List com;

  Wilaya();
  Future<List<Wilaya>> getwilaya() async {
    List<Wilaya> wilaya = new List<Wilaya>();
    Wilaya wil = new Wilaya();
    await FirebaseFirestore.instance.collection('Wilayas').get()
      ..docs.forEach((element) {
        if (element.data().isNotEmpty) {
          wil = Wilaya.fromJson(element.data());
          print(element.data()["wilaya"]);
          wilaya.add(wil);
        }
      });

    return wilaya;
  }

  Wilaya.fromJson(Map<String, dynamic> json) {
    name = json["wilaya"];
    code = json["nbr_wilaya"];
    com = json["daira"];
  }
}
