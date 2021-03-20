class Order {
  String orderId;
  int date;
  String bname;
  String adresse;
  String carteChifa;
  String ordonnance;
  String status;
  String livraison;
  String uid;
  Order(
      {this.bname,
      this.date,
      this.carteChifa,
      this.orderId,
      this.ordonnance,
      this.status,
      this.adresse,
      this.livraison,
      this.uid});

  Order.fromJson(Map<String, dynamic> json) {
    orderId = json['OrderId'];
    date = json['Time'];
    bname = json['bname'];
    livraison = json['Livraison'];
    adresse = json['adresse'];
    carteChifa = json['carteChifa'];
    ordonnance = json['ordonnance'];
    status = json['status'];
    uid = json['uid'];
  }
}
