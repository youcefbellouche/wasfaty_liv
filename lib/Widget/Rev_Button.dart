import 'package:flutter/material.dart';

class Rev_Button extends StatelessWidget {
  Function? onpressed;
  String? label;
  Color? color;
  Rev_Button({this.onpressed, this.label,this.color});
  @override
  Widget build(BuildContext context) {
    return Container(
      child: FlatButton(
          height: 45,
          color: color,
          minWidth: MediaQuery.of(context).size.width * 0.4,
          child: Text(this.label!, style: const TextStyle(color: Colors.white)),
          shape: RoundedRectangleBorder(
              side: const BorderSide(
                  color: Colors.green, style: BorderStyle.solid),
              borderRadius: BorderRadius.circular(50)),
          onPressed: this.onpressed as void Function()?),
    );
  }
}
