import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:wasfaty_liv/Functions/Auth/Rev_Auth.dart';
import 'package:wasfaty_liv/Widget/Rev_Appbar.dart';

import '../../Widget/Rev_Button.dart';
import '../../Widget/Rev_TextFeild.dart';

class Rev_phoneUpdate extends StatefulWidget {
  final String uid;
  final String oldphone;

  Rev_phoneUpdate({this.uid, this.oldphone});

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
  bool loading = false;

  Rev_Auth auth = new Rev_Auth();
  void ofPage() {
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return loading
        ? Scaffold(
            body: Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage("assets/auth/login.png"),
                    fit: BoxFit.cover),
              ),
              child: Center(
                child: CircularProgressIndicator(),
              ),
            ),
          )
        : Scaffold(
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
                                  borderSide: const BorderSide(
                                      color: Color(0xff218171)),
                                  borderRadius: BorderRadius.circular(20)),
                              enabledBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                      color: Color(0xff218171)),
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
                              if ((!input.startsWith("05") &&
                                      !input.startsWith("07") &&
                                      !input.startsWith("06")) ||
                                  input.length != 10) {
                                return "Donner un numero valide";
                              }
                            }),
                        Rev_Button(
                          label: "Changer le numero",
                          onpressed: () {
                            setState(() {
                              loading = true;
                            });
                            if (_formKey.currentState.validate()) {
                              if (widget.oldphone != newphone) {
                                auth.updatePhoneNum(
                                    phone: newphone,
                                    uid: widget.uid,
                                    context: context);
                              } else {
                                showDialog(
                                    useSafeArea: false,
                                    context: context,
                                    builder: (_) => AlertDialog(
                                          shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(10.0))),
                                          content: Center(
                                              widthFactor: 20,
                                              heightFactor: 2,
                                              child: Text(
                                                "Changer le numero",
                                                style: TextStyle(
                                                    fontWeight:
                                                        FontWeight.bold),
                                              )),
                                          actions: [
                                            FlatButton(
                                                onPressed: () {
                                                  setState(() {
                                                    loading = false;
                                                  });
                                                  Navigator.of(context).pop();
                                                },
                                                child: Text("ok")),
                                          ],
                                        ));
                              }
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
