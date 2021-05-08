class Order {
  String? orderId;
  int? date;
  int? dateTeminer;
  int? dateAnnuler;
  String? bname;
  int? bDate;
  String? adresse;
  List? carteChifa;
  String? annulerBy;
  String? noteAnnuler;
  List? ordonnance;
  String? status;
  String? livraison;
  String? uid;
  String? devis;
  String? pharmacieid;
  List<dynamic>? alarmIds;
  String? wilaya;
  String? daira;
  String? livreurid;
  String? generique;
  Order(
      {this.bname,
      this.livreurid,
      this.bDate,
      this.generique,
      this.dateAnnuler,
      this.dateTeminer,
      this.annulerBy,
      this.noteAnnuler,
      this.alarmIds,
      this.devis,
      this.date,
      this.carteChifa,
      this.orderId,
      this.ordonnance,
      this.wilaya,
      this.status,
      this.pharmacieid,
      this.daira,
      this.adresse,
      this.livraison,
      this.uid});

  Order.fromJson(Map<String, dynamic> json) {
    orderId = json['OrderId'];
    pharmacieid = json['pharmacieId'];
    alarmIds = json['alarmIds'];
    date = json['Time'];
    bDate = json['date de naissance du beneficiaire'];
    dateTeminer = json['DateTerminer'];
    dateAnnuler = json['DateAnnuler'];
    devis = json['devis'];
    bname = json['bname'];
    livraison = json['Livraison'];
    adresse = json['adresse'];
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
