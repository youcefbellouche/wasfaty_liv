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
  String devis;
  String pharmacieid;
  String wilaya;
  String livreurid;
  String generique;
  Order(
      {this.bname,
      this.livreurid,
      this.generique,
      this.devis,
      this.date,
      this.carteChifa,
      this.orderId,
      this.ordonnance,
      this.wilaya,
      this.status,
      this.pharmacieid,
      this.adresse,
      this.livraison,
      this.uid});

  Order.fromJson(Map<String, dynamic> json) {
    orderId = json['OrderId'];
    pharmacieid = json['pharmacieId'];
    date = json['Time'];
    devis = json['devis'];
    bname = json['bname'];
    livraison = json['Livraison'];
    adresse = json['adresse'];
    carteChifa = json['carteChifa'];
    ordonnance = json['ordonnance'];
    status = json['status'];
    uid = json['uid'];
    wilaya = json['wilaya'];
    generique = json['generique'] ? 'Oui' : 'Nom';
    livreurid = json['livreurId'];
  }
}
