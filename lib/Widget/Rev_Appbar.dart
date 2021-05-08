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
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(width: MediaQuery.of(context).size.width * 0.05),
                Container(
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(40)),
                    child: IconButton(icon: revIcon, onPressed: openDrawer as void Function()?)),
                SizedBox(width: MediaQuery.of(context).size.width * 0.2),
                Container(
                  child: Center(
                    child: Text(
                      'Wasfaty Livreur',
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontStyle: FontStyle.italic,
                          fontSize: 17),
                    ),
                  ),
                )
              ],
            ),
          ),

          Container(), // Required some widget in between to float AppBar
        ],
      ),
    ),
  );
}
