import 'dart:io';

import 'package:flutter/material.dart';

class Rev_RoundButton extends StatelessWidget {
  bool? isfile;
  File? file;
  String? label;
  Function? onpressed;
  Function? onpressedP;
  String? image;
  Rev_RoundButton(
      {this.label,
      this.onpressed,
      this.image,
      this.file,
      this.isfile,
      this.onpressedP});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: GestureDetector(
        onTap: isfile! ? this.onpressedP as void Function()? : this.onpressed as void Function()?,
        child: new Container(
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: (this.isfile!
                      ? FileImage(this.file!)
                      : AssetImage(this.image!)) as ImageProvider<Object>,
                  fit: BoxFit.cover)),
          height: 130.0,
          width: 130.0,
        ),
      ),
    );
  }
}
