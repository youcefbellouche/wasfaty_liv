import 'package:flutter/material.dart';

class Rev_TextFeild extends StatelessWidget {
  String? label;
  TextInputType? textInputType;
  TextEditingController? textEditingController;
  FormFieldValidator<String>? validator;
  bool? mdp;
  final ValueChanged<String>? onChanged;
  IconButton? suffixIcon;
  Rev_TextFeild(
      {this.label,
      this.textEditingController,
      this.validator,
      this.mdp,
      this.onChanged,this.textInputType,this.suffixIcon});
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(12),
      child: TextFormField(
        
        onChanged: this.onChanged,
        validator: this.validator,
        style: const TextStyle(color: Colors.black),
        controller: this.textEditingController,
        keyboardType: this.textInputType,
        obscureText: this.mdp!,
        decoration: InputDecoration(
          suffixIcon: this.suffixIcon,
            labelStyle: const TextStyle(color: Colors.black),
            border: OutlineInputBorder(
                borderSide: const BorderSide(color: Color(0xff218171)),
                borderRadius: BorderRadius.circular(20)),
            enabledBorder: OutlineInputBorder(
                borderSide: const BorderSide(color:Color(0xff218171)),
                borderRadius: BorderRadius.circular(20)),
            labelText: this.label),
      ),
    );
  }
}
