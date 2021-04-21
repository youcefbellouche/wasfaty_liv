import 'package:flutter/material.dart';

import 'Rev_RoundButton.dart';

class Rev_vide extends StatelessWidget {
  String img;
  String msg;
  Rev_vide({this.img, this.msg});
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Rev_RoundButton(
              isfile: false,
              image: img,
            ),
            msg != null
                ? Text(
                    msg,
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  )
                : Container()
          ],
        ),
      ),
    );
  }
}
