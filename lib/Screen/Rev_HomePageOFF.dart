import 'package:flutter/material.dart';
import 'package:wasfaty_liv/Widget/Rev_RoundButton.dart';

class Rev_HomePageOFF extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
          Rev_RoundButton(
            isfile: false,
            image: "assets/no_inter.png",
          ),
          Text(
            'Vous n\'avez pas de connexion',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          )
        ]));
  }
}
