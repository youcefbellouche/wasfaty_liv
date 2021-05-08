import 'package:flutter/material.dart';
import 'package:dropdown_search/dropdown_search.dart';

import 'Rev_vide.dart';

class Rev_DropDown extends StatefulWidget {
  List<String>? wil;
  String? valuew;
  Function? onchanged;
  String? hint;
  Function? validator;

  Rev_DropDown(
      {this.wil, this.valuew, this.onchanged, this.hint, this.validator});

  @override
  _Rev_DropDownState createState() => _Rev_DropDownState();
}

class _Rev_DropDownState extends State<Rev_DropDown> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(12),
      child: DropdownSearch<String>(
        validator: widget.validator as String? Function(String?)?,
        emptyBuilder: (BuildContext context, String? test) {
          return Rev_vide(
            img: "assets/vide.png",
          );
        },
        errorBuilder: (BuildContext context, String? test, dynamic t) {
          return Container();
        },
        dropdownSearchDecoration: InputDecoration(
          contentPadding: const EdgeInsets.only(top: 5, bottom: 5, left: 12),
          suffixIcon: const Icon(
            Icons.arrow_drop_down,
            color: Colors.black,
          ),
          hintStyle: const TextStyle(color: Colors.black),
          suffixStyle: const TextStyle(color: Colors.black),
          fillColor: Colors.white,
          filled: true,
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20.0),
            borderSide: const BorderSide(
              color: Color(0xff218171),
            ),
          ),
          disabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20.0),
            borderSide: const BorderSide(
              color: const Color(0xff218171),
            ),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20.0),
            borderSide: const BorderSide(
              color: const Color(0xfff94620),
              width: 1,
            ),
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15.0),
            borderSide: const BorderSide(
              color: Colors.white,
              width: 0.5,
            ),
          ),
        ),
        mode: Mode.DIALOG,
        items: widget.wil,
        hint: widget.hint,
        onChanged: widget.onchanged as void Function(String?)?,
        showSearchBox: true,
        showSelectedItem: true,
        searchBoxDecoration: InputDecoration(
            border: OutlineInputBorder(
                borderSide: BorderSide(
                    color: Colors.white, width: 1, style: BorderStyle.solid)),
            contentPadding: EdgeInsets.fromLTRB(12, 12, 8, 0),
            labelText: "Rechercher",
            labelStyle: TextStyle(color: Colors.black)),
        popupTitle: Container(
          height: 50,
          decoration: BoxDecoration(
            color: Theme.of(context).accentColor,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
          ),
          child: Center(
            child: Text(
              'les Wilayas',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
        ),
        popupBackgroundColor: Colors.white,
        popupShape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(24),
              topRight: Radius.circular(24),
              bottomRight: Radius.circular(15),
              bottomLeft: Radius.circular(15)),
        ),
        dropDownButton: Container(),
      ),
    );
  }
}
