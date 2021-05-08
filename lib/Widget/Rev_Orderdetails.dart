import 'package:flutter/material.dart';

class Rev_Orderdetails extends StatelessWidget {
  String? label;
  String? info;
  Rev_Orderdetails({this.label, this.info});
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(children: [
        Text(
          this.label!,
          textAlign: TextAlign.left,
          style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
              color: Theme.of(context).primaryColor,
              height: 35,
              width: MediaQuery.of(context).size.width * 0.9,
              child: Center(
                  child: Text(
                this.info!,
                style:
                    TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              ))),
        ),
      ]),
    );
  }
}
