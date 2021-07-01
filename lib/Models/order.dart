class Order {
  String? orderId;
  int? date;
  String? medic;
  int? dateTeminer;
  int? dateAnnuler;
  String? bname;
  int? bDate;
  String? adresse;
  String? livraisonPrice;
  List? carteChifa;
  String? annulerBy;
  String? noteAnnuler;
  List? ordonnance;
  List? medicPic;
  String? status;
  bool? livraison;
  String? uid;
  String? devis;
  String? pharmacieid;
  String? wilaya;
  String? daira;
  double? lat;
  double? long;
  String? livreurid;
  String? generique;
  Order(
      {this.bname,
      this.livreurid,
      this.bDate,
      this.generique,
      this.medic,
      this.dateAnnuler,
      this.dateTeminer,
      this.annulerBy,
      this.noteAnnuler,
      this.devis,
      this.date,
      this.carteChifa,
      this.orderId,
      this.ordonnance,
      this.wilaya,
      this.livraisonPrice,
      this.status,
      this.pharmacieid,
      this.daira,
      this.adresse,
      this.lat,
      this.long,
      this.livraison,
      this.uid});

  Order.fromJson(Map<String, dynamic> json) {
    orderId = json['OrderId'];
    pharmacieid = json['pharmacieId'];
    date = json['Time'];
    livraisonPrice = json['livraisonPrice'];
    medic = json['medicament'];
    medicPic = json['medicamentPic'];
    bDate = json['date de naissance du beneficiaire'];
    dateTeminer = json['DateTerminer'];
    dateAnnuler = json['DateAnnuler'];
    devis = json['devis'];
    bname = json['bname'];
    livraison = json['Livraison'];
    adresse = json['adresse'];
    lat = json['lat'];
    long = json['long'];
    json['carteChifa'] == null
        ? carteChifa = []
        : carteChifa = json['carteChifa'];
    json['ordonnance'] == null
        ? ordonnance = []
        : ordonnance = json['ordonnance'];
    status = json['status'];
    noteAnnuler = json['noteAnnuler'];
    annulerBy = json['annulerBy'];
    uid = json['uid'];
    wilaya = json['wilaya'];
    daira = json['daira'];
    generique = json['generique'] ? 'Oui' : 'Nom';
    livreurid = json['livreurId'];
  }
}
