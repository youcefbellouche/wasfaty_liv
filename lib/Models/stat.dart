class Stat {
  int? nbrCommandeLOCAL;
  int? nbrCommandeTerminerLOCAL;
  int? nbrCommandeETR;
  int? nbrCommandeTerminerETR;
  int? nbrCommandeLOCALMedic;
  int? nbrCommandeTerminerLOCALMedic;
  int? nbrCommandeTerminerETRMedic;
  int? nbrCommandeETRMedic;

  Stat(
      {this.nbrCommandeLOCAL,
      this.nbrCommandeTerminerLOCAL,
      this.nbrCommandeLOCALMedic,
      this.nbrCommandeETRMedic,
      this.nbrCommandeETR,
      this.nbrCommandeTerminerETR,
      this.nbrCommandeTerminerETRMedic,
      this.nbrCommandeTerminerLOCALMedic});

  Stat.fromJson(Map<String, dynamic> json) {
    nbrCommandeETR =
        json['nbrCommandeETR'] != null ? json['nbrCommandeETR'] : 0;
    nbrCommandeTerminerETR = json['nbrCommandeTerminerETR'] != null
        ? json['nbrCommandeTerminerETR']
        : 0;
    nbrCommandeLOCAL =
        json['nbrCommandeLOCAL'] != null ? json['nbrCommandeLOCAL'] : 0;
    nbrCommandeTerminerLOCAL = json['nbrCommandeTerminerLOCAL'] != null
        ? json['nbrCommandeTerminerLOCAL']
        : 0;
    nbrCommandeLOCALMedic = json['nbrCommandeLOCALMedic'] != null
        ? json['nbrCommandeLOCALMedic']
        : 0;
    nbrCommandeTerminerLOCALMedic =
        json['nbrCommandeTerminerLOCALMedic'] != null
            ? json['nbrCommandeTerminerLOCALMedic']
            : 0;
    nbrCommandeTerminerETRMedic = json['nbrCommandeTerminerETRMedic'] != null
        ? json['nbrCommandeTerminerETRMedic']
        : 0;
    nbrCommandeETRMedic =
        json['nbrCommandeETRMedic'] != null ? json['nbrCommandeETRMedic'] : 0;
  }
}
