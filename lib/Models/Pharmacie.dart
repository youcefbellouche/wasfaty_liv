class Pharmacie {
  String? name;
  String? id;
  bool? active;
  String? phone;
  String? adress;
  String? wilaya;
  String? daira;
  String? email;
  double? lat;
  double? long;
  Pharmacie(
      {this.name,
      this.phone,
      this.adress,
      this.wilaya,
      this.daira,
      this.email,
      this.active,
      this.id,
      this.lat,
      this.long});
  Pharmacie.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    id = json['id'];
    adress = json['adresse'];
    wilaya = json['wilaya'];
    daira = json['daira'];
    phone = json['phone'];
    lat = json['lat'];
    long = json['long'];
    active = json['active'];
    email = json['email'];
  }
}
