class Alarm {
  late String medicament;
  late MedicType medicType;
  late int id;
  late List ids;
  late String note;
  late String quantity;
  late int dure;
  late int jourInterv;
  late DateTime hours;
  late int heure;
  late String alarmBy;
  late String livreurId;
  late String orderId;
  late int minute;

  Alarm(
      {required this.dure,
      required this.hours,
      required this.id,
      required this.ids,
      required this.alarmBy,
      required this.livreurId,
      required this.jourInterv,
      required this.note,
      required this.medicament,
      required this.quantity,
      required this.orderId,
      required this.medicType,
      required this.heure,
      required this.minute});
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
        ? 0 as DateTime
        : DateTime.fromMillisecondsSinceEpoch(json['date']);
    heure = json['heure'];
    minute = json['minute'];
  }
}

class Medicament {
  String? name;
  MedicType? type;
  Medicament({this.name, this.type});
}

enum MedicType { PILULE, INJECTION, GOUTTES, INHALATEUR, POUDRE, LIQUIDE }
