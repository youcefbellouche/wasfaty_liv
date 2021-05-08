class Stat {
  int? caLOCAL;
  int? nbrCommandeLOCAL;
  int? nbrCommandeTerminerLOCAL;


  Stat(
      {
      this.caLOCAL,
      this.nbrCommandeLOCAL,
      this.nbrCommandeTerminerLOCAL,
});

  Stat.fromJson(Map<String, dynamic> json) {
    caLOCAL = json['CALOCAL']!= null ? json['CALOCAL'] : 0;
    nbrCommandeLOCAL = json['nbrCommandeTerminerETR']!= null ? json['nbrCommandeTerminerETR'] : 0;
    nbrCommandeTerminerLOCAL = json['nbrCommandeTerminerLOCAL']!= null ? json['nbrCommandeTerminerLOCAL'] : 0;

  }
}
