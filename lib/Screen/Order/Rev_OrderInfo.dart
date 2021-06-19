import 'package:flutter/material.dart';
import 'package:wasfaty_liv/Models/order.dart';
import 'package:wasfaty_liv/Widget/Rev_Appbar.dart';

import 'Rev_CommandeInfo.dart';
import 'Rev_PharmacieInfo.dart';
import 'Rev_AlarmList.dart';

class Rev_OrderInfo extends StatefulWidget {
  Order? order;
  String collection;

  Rev_OrderInfo({
    this.order,
    required this.collection,
  });

  @override
  _Rev_OrderInfoState createState() => _Rev_OrderInfoState();
}

class _Rev_OrderInfoState extends State<Rev_OrderInfo> {
  void ofPage() {
    Navigator.pop(context);
  }

  List<String> ord = <String>[];
  List<String> chif = <String>[];
  List<String> medic = <String>[];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    widget.order!.ordonnance!.forEach((elementO) {
      ord.add(elementO.toString());
    });
    if (widget.order!.carteChifa!.length != 0) {
      widget.order!.carteChifa!.forEach((elementC) {
        chif.add(elementC.toString());
      });
    }
    if (widget.order!.medicPic!.length != 0) {
      widget.order!.medicPic!.forEach((element) {
        medic.add(element.toString());
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
          appBar: Rev_Appbar(
            context,
            AppBar().preferredSize.height,
            ofPage,
            Icon(
              Icons.arrow_back,
              color: Theme.of(context).primaryColor,
            ),
          ) as PreferredSizeWidget?,
          body: Column(
            children: [
              TabBar(
                  unselectedLabelColor: Colors.grey,
                  labelColor: Theme.of(context).primaryColor,
                  indicatorColor: Theme.of(context).accentColor,
                  tabs: [
                    Tab(
                      text: "Commande",
                    ),
                    Tab(text: "Pharmacie"),
                    Tab(text: "Alarm"),
                  ]),
              Expanded(
                child: TabBarView(
                  children: [
                    Rev_CommandeInfo(
                      order: widget.order,
                      collection: widget.collection,
                      chif: chif,
                      ord: ord,
                      medic: medic,
                    ),
                    Rev_PharmacieInfo(
                      pharmacieid: widget.order!.pharmacieid,
                    ),
                    Rev_AlarmList(
                      orderId: widget.order!.orderId,
                      patientId: widget.order!.uid,
                    ),
                  ],
                ),
              ),
            ],
          )),
    );
  }
}
