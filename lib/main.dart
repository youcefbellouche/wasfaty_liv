import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'Screen/Rev_HomePage.dart';
import 'Screen/Rev_HomePageOFF.dart';
import 'Screen/auth/Rev_LoginPage.dart';
import 'package:connectivity/connectivity.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
  var result = FirebaseAuth.instance.currentUser;

  @override
  void initState() {
    super.initState();
    GetConnect();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: isInternetOn
          ? result != null
              ? Rev_HomePage(id: result.uid)
              : LoginPage()
          : Rev_HomePageOFF(),
    );
  }

  // ignore: non_constant_identifier_names
  void GetConnect() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.none) {
      setState(() {
        isInternetOn = false;
      });
    } else if (connectivityResult == ConnectivityResult.mobile) {
      setState(() {
        isInternetOn = true;
      });
    } else if (connectivityResult == ConnectivityResult.wifi) {
      setState(() {
        isInternetOn = true;
      });
    }
  }
}
