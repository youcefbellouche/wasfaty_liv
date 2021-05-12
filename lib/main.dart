import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/services.dart';
import 'package:new_version/new_version.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:wasfaty_liv/Functions/Auth/Rev_push_notification.dart';
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
        title: 'Wasfaty Livreur',
        home: SplashScreen());
  }
}

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Timer(Duration(seconds: 5), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => HomeConnect()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
            image: AssetImage("assets/auth/splash.png"), fit: BoxFit.fill),
      ),
    );
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
    WidgetsBinding.instance!.addObserver(this);
    test();
    _checkVersion();
  }

  test() async {
    await Rev_PushNotification().initialize();
  }

  @override
  void dispose() {
    WidgetsBinding.instance!.removeObserver(this);
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
            .doc(FirebaseAuth.instance.currentUser!.uid)
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

  void _checkVersion() async {
    final newVersion = NewVersion(
      androidId: "rev.wasfaty.livreur",
    );
    final status = await newVersion.getVersionStatus();
    if (status!.localVersion != status.storeVersion) {
      await Future.delayed(Duration(milliseconds: 50));
      showDialog(
          barrierDismissible: false,
          context: context,
          builder: (BuildContext context) {
            return _popUp(context, status);
          });
    }

    print("DEVICE : " + status.localVersion);
    print("STORE : " + status.storeVersion);
  }

  Widget _popUp(BuildContext context, VersionStatus status) {
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: new AlertDialog(
        title: Text("Mise à jour disponible"),
        content: Container(
          height: MediaQuery.of(context).size.height * 0.2,
          child: Column(
            children: [
              Expanded(
                child: Text(
                  "Please update the app from " +
                      "${status.localVersion}" +
                      " to " +
                      "${status.storeVersion}",
                  textAlign: TextAlign.left,
                  style: const TextStyle(color: Colors.black),
                ),
              ),
              Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    FlatButton(
                        height: 45,
                        color: Colors.red,
                        minWidth: 40,
                        child: Text("Refuser",
                            style: const TextStyle(color: Colors.white)),
                        shape: RoundedRectangleBorder(
                            side: const BorderSide(
                                color: Colors.red, style: BorderStyle.solid),
                            borderRadius: BorderRadius.circular(50)),
                        onPressed: () async {
                          SystemNavigator.pop();
                        }),
                    FlatButton(
                        height: 45,
                        color: Colors.green[600],
                        minWidth: 40,
                        child: Text("Fait les MAJ",
                            style: const TextStyle(color: Colors.white)),
                        shape: RoundedRectangleBorder(
                            side: const BorderSide(
                                color: Colors.green, style: BorderStyle.solid),
                            borderRadius: BorderRadius.circular(50)),
                        onPressed: () async {
                          _launchGooglePlay();
                        }),
                  ]),
            ],
          ),
        ),
      ),
    );
  }

  _launchGooglePlay() async {
    if (await canLaunch(
        "https://play.google.com/store/apps/details?id=rev.wasfaty.livreur")) {
      final bool nativeAppLaunch = await launch(
          "https://play.google.com/store/apps/details?id=rev.wasfaty.livreur",
          forceWebView: false,
          universalLinksOnly: true);
      print("update test $nativeAppLaunch");
    }
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
