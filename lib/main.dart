import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'Screen/Rev_HomePage.dart';
import 'Screen/auth/Rev_LoginPage.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: ThemeData(
          primaryColor: const Color(0xff218171),
          accentColor: const Color(0xff1b6053),
          focusColor: const Color(0xff218171),
          hoverColor: const Color(0xff218171),
        ),
        debugShowCheckedModeBanner: false,
        title: 'Wasfaty Pharmacie',
        home: HomeConnect());
  }
}

class HomeConnect extends StatefulWidget {
  @override
  _HomeConnectState createState() => _HomeConnectState();
}

class _HomeConnectState extends State<HomeConnect> {
  bool isInternetOn = true;
  bool logged = false;
  String id;
  @override
  void initState() {
    super.initState();
    getLocalData();
  }

  Future<void> getLocalData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    logged = prefs.getBool('logged');
    if (logged == null) {
      logged = false;
    }
    if (logged) {
      id = prefs.getString('id');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: logged ? Rev_HomePage(id: id) : LoginPage());
  }
}
