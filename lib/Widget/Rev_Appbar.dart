import 'package:flutter/material.dart';

Widget Rev_Appbar(
    BuildContext context, double revHeight, Function openDrawer, Icon revIcon) {
  return PreferredSize(
    preferredSize: Size(MediaQuery.of(context).size.width, revHeight + 10),
    child: Container(
      color: Colors.transparent,
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
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                    margin: EdgeInsets.only(left: 20),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(40)),
                    child: IconButton(
                        icon: revIcon,
                        onPressed: openDrawer as void Function()?)),
                Container(
                  margin: EdgeInsets.only(right: 10),
                  child: Center(
                      child: Image(
                    image: AssetImage("assets/logo.png"),
                  )),
                ),
                Container(
                    margin: EdgeInsets.only(right: 10),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(40)),
                    child: IconButton(
                        icon: Icon(
                          Icons.info_outline,
                          color: Theme.of(context).primaryColor,
                        ),
                        onPressed: openDrawer as void Function()?)),
              ],
            ),
          ),

          Container(), // Required some widget in between to float AppBar
        ],
      ),
    ),
  );
}
