class Alarm {
  String medicament;
  MedicType medicType;
  int id;
  List ids;
  String note;
  String quantity;
  int dure;
  int jourInterv;
  DateTime hours;
  int heure;
  String alarmBy;
  String livreurId;
  String orderId;
  int minute;

  Alarm(
      {this.dure,
      this.hours,
      this.id,
      this.ids,
      this.alarmBy,
      this.livreurId,
      this.jourInterv,
      this.note,
      this.medicament,
      this.quantity,
      this.orderId,
      this.medicType,
      this.heure,
      this.minute});
  Alarm.fromJson(Map<String, dynamic> json) {
    medicament = json['nom du medicament'];
    medicType = json['type du medicament'];
    id = json['id'] == null ? 0 : json['id'];
    ids = json['ids'];
    orderId = json['orderId'];
    alarmBy = json['alarmBy'];
    livreurId = json['alarmId'];
    note = json['note'];
    quantity = json['quantity'];
    dure = json['duré'];
    jourInterv = json['jourInterv'];
    hours = json['date'] == null
        ? 0
        : DateTime.fromMillisecondsSinceEpoch(json['date']);
    heure = json['heure'];
    minute = json['minute'];
  }
}

class Medicament {
  String name;
  MedicType type;
  Medicament({this.name, this.type});
}

enum MedicType { PILULE, INJECTION, GOUTTES, INHALATEUR, POUDRE, LIQUIDE }
