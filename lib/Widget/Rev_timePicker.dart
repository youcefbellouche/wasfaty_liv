import 'package:flutter/material.dart';

class Rev_timePicker extends StatefulWidget {
  @required
  TimeOfDay? time;
  @required
  TimeOfDay? pick;
  @required
  Function? onchanged;
  @required
  String? label;
  Function? validator;
  TextEditingController? controller;
  Rev_timePicker(
      {this.time,
      this.pick,
      this.validator,
      this.onchanged,
      this.label,
      this.controller});
  @override
  _Rev_timePickerState createState() => _Rev_timePickerState();
}

class _Rev_timePickerState extends State<Rev_timePicker> {
  MaterialColor kPrimaryColor = const MaterialColor(
    0xff218171,
    const <int, Color>{
      50: const Color(0xff218171),
      100: const Color(0xff218171),
      200: const Color(0xff218171),
      300: const Color(0xff218171),
      400: const Color(0xff218171),
      500: const Color(0xff218171),
      600: const Color(0xff218171),
      700: const Color(0xff218171),
      800: const Color(0xff218171),
      900: const Color(0xff218171),
    },
  );
  @override
  Widget build(BuildContext context) {
    TimeOfDay? timeN;
    return Container(
      padding: EdgeInsets.all(12),
      child: TextFormField(
        controller: widget.controller,
        validator: widget.validator as String? Function(String?)?,
        readOnly: true,
        onTap: () async {
          timeN = await showTimePicker(
              context: context,
              builder: (BuildContext context, Widget? child) {
                return Theme(
                  child: child!,
                  data: ThemeData.light().copyWith(
                    colorScheme: ColorScheme.fromSwatch(
                      primarySwatch: kPrimaryColor,
                      primaryColorDark: Colors.green,
                      accentColor: Colors.green,
                    ),
                    dialogBackgroundColor: Colors.white,
                  ),
                );
              },
              initialEntryMode: TimePickerEntryMode.input,
              initialTime: TimeOfDay.now());
          widget.onchanged!(timeN);
        },
        textAlign: TextAlign.center,
        decoration: InputDecoration(
          labelText: widget.label,
          hintText: "${widget.time!.format(context)}",
          hintStyle: TextStyle(color: Colors.black),
          labelStyle: const TextStyle(color: Colors.black),
          border: OutlineInputBorder(
              borderSide: const BorderSide(color: Color(0xff218171)),
              borderRadius: BorderRadius.circular(20)),
          enabledBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: Color(0xff218171)),
              borderRadius: BorderRadius.circular(20)),
        ),
      ),
    );
  }
}
