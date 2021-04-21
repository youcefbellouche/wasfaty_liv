import 'package:flutter/material.dart';
import 'package:wasfaty_liv/Models/order.dart';
import 'package:wasfaty_liv/Screen/Order/Rev_OrderInfo.dart';

class Rev_OrderCard extends StatefulWidget {
  Order order;
  String collection;

  Rev_OrderCard({this.order, this.collection});
  @override
  _Rev_OrderCardState createState() => _Rev_OrderCardState();
}

class _Rev_OrderCardState extends State<Rev_OrderCard> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: InkWell(
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => Rev_OrderInfo(
                        order: widget.order,
                        collection: widget.collection,
                      )));
        },
        child: Container(
          height: 180,
          decoration: BoxDecoration(
              border:
                  Border.all(color: Theme.of(context).primaryColor, width: 3),
              color: Theme.of(context).primaryColor,
              borderRadius: BorderRadius.all(
                Radius.circular(13),
              )),
          child: Column(
            children: [
              Container(
                  height: 180 * 0.16,
                  child: Center(
                      child: Text(
                    'Commande : ',
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold),
                  ))),
              Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(
                        Radius.circular(5),
                      )),
                  width: MediaQuery.of(context).size.width,
                  height: 180 * 0.16,
                  child: Center(child: Text(widget.order.orderId))),
              Container(
                  height: 180 * 0.16,
                  child: Center(
                      child: Text(
                    'Type de Commande :',
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold),
                  ))),
              Container(
                  height: 180 * 0.16,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(
                        Radius.circular(5),
                      )),
                  child: Center(
                      child: Text(widget.collection == "Commande"
                          ? "Commande Local"
                          : "Commande de l'étrenger"))),
              Container(
                  height: 180 * 0.16,
                  child: Center(
                      child: Text(
                    'Prix :',
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold),
                  ))),
              Container(
                  height: 180 * 0.16,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(
                        Radius.circular(5),
                      )),
                  child: Center(child: Text("${widget.order.devis} DA"))),
            ],
          ),
        ),
      ),
    );
  }
}
