import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../../Functions/Auth/Rev_Auth.dart';
import '../Rev_ProfilePage.dart';
import '../../Widget/Rev_Appbar.dart';
import '../../Screen/Rev_ProfilePage.dart';

import '../../Widget/Rev_Button.dart';
import '../../Widget/Rev_TextFeild.dart';

import '../Rev_HomePage.dart';

class Rev_phoneUpdate extends StatefulWidget {
  final String id;
  final String oldphone;

  Rev_phoneUpdate({this.id, this.oldphone});

  @override
  _Rev_phoneUpdateState createState() => _Rev_phoneUpdateState();
}

class _Rev_phoneUpdateState extends State<Rev_phoneUpdate> {
  TextEditingController controller_pass;
  TextEditingController controller_newPass;
  TextEditingController controller_confirmNewPass;

  final _formKey = GlobalKey<FormState>();
  User fuser;

  String newphone;

  Rev_Auth auth = new Rev_Auth();
  void ofPage() {
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Rev_Appbar(
        context,
        AppBar().preferredSize.height,
        ofPage,
        Icon(
          Icons.arrow_back,
          color: Theme.of(context).primaryColor,
        ),
      ),
      body: Center(
        child: ListView(
          children: [
            SizedBox(height: MediaQuery.of(context).size.height / 10),
            SizedBox(height: 200, child: Image.asset("assets/logo.png")),
            Form(
              key: _formKey,
              child: Column(
                children: [
                  Container(
                    padding: EdgeInsets.all(12),
                    child: TextFormField(
                      initialValue: widget.oldphone,
                      readOnly: true,
                      textAlign: TextAlign.center,
                      decoration: InputDecoration(
                        labelStyle: const TextStyle(color: Colors.black),
                        border: OutlineInputBorder(
                            borderSide:
                                const BorderSide(color: Color(0xff218171)),
                            borderRadius: BorderRadius.circular(20)),
                        enabledBorder: OutlineInputBorder(
                            borderSide:
                                const BorderSide(color: Color(0xff218171)),
                            borderRadius: BorderRadius.circular(20)),
                      ),
                    ),
                  ),
                  Rev_TextFeild(
                      label: "Noveau N° de telephone",
                      textEditingController: controller_confirmNewPass,
                      mdp: false,
                      textInputType: TextInputType.number,
                      onChanged: (value) => newphone = value,
                      validator: (input) {
                        if (!input.startsWith("0") || input.length != 10) {
                          return "Donner un numero valide";
                        }
                      }),
                  Rev_Button(
                    label: "Changer le numero",
                    onpressed: () {
                      if (_formKey.currentState.validate()) {
                        if (widget.oldphone != newphone) {
                          print("ana howa ana  ${widget.oldphone}");
                          print(newphone);
                          auth.updatePhoneNum(phone: newphone, id: widget.id);
                        }
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Rev_ProfilePage(
                                      id: widget.id,
                                    )));
                      }
                    },
                    color: Theme.of(context).primaryColor,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
