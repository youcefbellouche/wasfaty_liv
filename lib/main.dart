import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'Screen/Rev_HomePage.dart';
import 'Screen/Rev_HomePageOFF.dart';
import 'Screen/auth/Rev_LoginPage.dart';
import 'package:connectivity/connectivity.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

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

class _HomeConnectState extends State<HomeConnect> with WidgetsBindingObserver {
  bool isInternetOn = true;
  var result = FirebaseAuth.instance.currentUser;

  @override
  void initState() {
    super.initState();
    GetConnect();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  Future<void> didChangeAppLifecycleState(AppLifecycleState state) async {
    super.didChangeAppLifecycleState(state);

    if (state == AppLifecycleState.inactive ||
        state == AppLifecycleState.paused) return;

    final isdown = state == AppLifecycleState.detached;

    if (isInternetOn && result != null) {
      if (isdown) {
        await FirebaseFirestore.instance
            .collection("Livreur")
            .doc(FirebaseAuth.instance.currentUser.uid)
            .update({
          "disponible": false,
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: isInternetOn
          ? result != null
              ? Rev_HomePage()
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
