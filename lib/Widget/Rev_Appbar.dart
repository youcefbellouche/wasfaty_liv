import 'package:flutter/material.dart';

Widget Rev_Appbar(
    BuildContext context, double revHeight, Function openDrawer, Icon revIcon) {
  return PreferredSize(
    preferredSize: Size(MediaQuery.of(context).size.width, revHeight + 10),
    child: Stack(
      children: <Widget>[
        Container(
          padding: EdgeInsets.only(top: revHeight * 0.3),
          decoration: BoxDecoration(
              color: Theme.of(context).primaryColor,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(60),
              )),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(width: MediaQuery.of(context).size.width * 0.05),
              Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(40)),
                  child: IconButton(icon: revIcon, onPressed: openDrawer)),
              SizedBox(width: MediaQuery.of(context).size.width * 0.23),
              Container(
                height: 100,
                width: 100,
                child: Center(
                //     child: Image(
                //   image: AssetImage("assets/logo.png"),
                // )
                child: Text('Commandes',style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 17
                ),),
                ),
              )
            ],
          ),
        ),

        Container(), // Required some widget in between to float AppBar
      ],
    ),
  );
}
