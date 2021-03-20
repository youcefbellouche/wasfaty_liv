import 'package:flutter/material.dart';
import 'dart:io';

import 'Rev_Appbar.dart';
import 'Rev_Button.dart';

class Rev_ViewPic extends StatefulWidget {
  File file;
  Function function;
  Rev_ViewPic({this.file, this.function});
  @override
  _Rev_ViewPicState createState() => _Rev_ViewPicState();
}

class _Rev_ViewPicState extends State<Rev_ViewPic> {
  void ofPage() {
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      appBar: Rev_Appbar(
        context,
        AppBar().preferredSize.height,
        ofPage,
        Icon(
          Icons.arrow_back,
          color: Theme.of(context).primaryColor,
        ),
      ),
      body: Column(
        children: [
          Center(
            child: Container(
                padding: EdgeInsets.only(top: 15),
                height: MediaQuery.of(context).size.height * 0.7,
                width: MediaQuery.of(context).size.width * 0.7,
                child: Image.file(widget.file, fit: BoxFit.cover)),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 50, right: 50, top: 20),
            child: Rev_Button(
              label: "Changer",
              onpressed: () {},
              color: Colors.green,
            ),
          ),
        ],
      ),
    );
  }
}
