class Stat {
  int nbrCommandeLOCAL;
  int nbrCommandeTerminerLOCAL;

  Stat({
    this.nbrCommandeLOCAL,
    this.nbrCommandeTerminerLOCAL,
  });

  Stat.fromJson(Map<String, dynamic> json) {
    nbrCommandeLOCAL = json['nbrCommandeTerminerETR'] != null
        ? json['nbrCommandeTerminerETR']
        : 0;
    nbrCommandeTerminerLOCAL = json['nbrCommandeTerminerLOCAL'] != null
        ? json['nbrCommandeTerminerLOCAL']
        : 0;
  }
}
