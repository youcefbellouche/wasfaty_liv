class Livreur {
  String name;
  String id;
  bool active;
  String password;
  String phone;
  String adress;
  String email;
  bool suspendue;
  Livreur(
      {this.name,
      this.suspendue,
      this.password,
      this.phone,
      this.adress,
      this.email,
      this.active});
  Livreur.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    id = json['id'];
    suspendue = json['suspendue'];
    password = json['password'];
    adress = json['adresse'];
    phone = json['phone'];
    active = json['active'];
    email = json['email'];
  }
}
