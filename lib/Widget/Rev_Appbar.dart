import 'package:flutter/material.dart';
import 'dart:async';
import 'package:url_launcher/url_launcher.dart';

Widget Rev_Appbar(
  BuildContext context,
  double revHeight,
  Function openDrawer,
  Icon revIcon,
) {
  return PreferredSize(
    preferredSize: Size(MediaQuery.of(context).size.width, revHeight + 10),
    child: Container(
      color: Colors.transparent,
      child: Stack(
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(top: revHeight * 0.3),
            decoration: BoxDecoration(
                color: Theme.of(context).primaryColor,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(60),
                )),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                    margin: EdgeInsets.only(left: 20),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(40)),
                    child: IconButton(
                        icon: revIcon,
                        onPressed: openDrawer as void Function()?)),
                Container(
                  margin: EdgeInsets.only(right: 10),
                  child: Center(
                      child: Image(
                    image: AssetImage("assets/logo.png"),
                  )),
                ),
                Container(
                    margin: EdgeInsets.only(right: 10),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(40)),
                    child: IconButton(
                      icon: Icon(
                        Icons.info_outline,
                        color: Theme.of(context).primaryColor,
                      ),
                      onPressed: () async {
                        infoPopUp(context);
                      },
                    ))
              ],
            ),
          ),

          Container(), // Required some widget in between to float AppBar
        ],
      ),
    ),
  );
}

Future<void> makePhoneCall(String url) async {
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}

Future<void> sendMail(String mail) async {
  String email = "mailto:$mail";
  if (await canLaunch(email)) {
    await launch(email);
  } else {
    throw 'Could not launch $email';
  }
}

Future openLink(
  String url,
) async {
  if (await canLaunch(url)) {
    await launch(url, forceWebView: true);
  } else {
    throw 'Could not launch $url';
  }
}

infoPopUp(context) {
  return showDialog(
      context: context,
      builder: (con) {
        return SimpleDialog(
          contentPadding: EdgeInsets.all(12),
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(20.0))),
          children: [
            Container(
                child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "Contact:",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  "S.a.r.l. WASFATY ATIBIYA.",
                  style: TextStyle(fontSize: 15),
                ),
                SizedBox(
                  height: 30,
                ),
                Text(
                  "Siège:",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  "Cité des frères Boussalem, Centre des affaires de Zéralda, B n°01, Alger.",
                  style: TextStyle(fontSize: 15),
                  textAlign: TextAlign.center,
                ),
                SizedBox(
                  height: 30,
                ),
                Text(
                  "Mobile : ",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 5,
                ),
                InkWell(
                    onTap: () async {
                      await makePhoneCall("tel:0660444062");
                    },
                    child: Text(
                      "06 60 44 40 62",
                      style: TextStyle(color: Colors.blue, fontSize: 15),
                    )),
                SizedBox(
                  height: 5,
                ),
                InkWell(
                    onTap: () async {
                      await makePhoneCall("tel:0660444063");
                    },
                    child: Text(
                      "06 60 44 40 63",
                      style: TextStyle(color: Colors.blue, fontSize: 15),
                    )),
                SizedBox(
                  height: 5,
                ),
                InkWell(
                    onTap: () async {
                      await makePhoneCall("tel:0660444038");
                    },
                    child: Text(
                      "06 60 44 40 38",
                      style: TextStyle(color: Colors.blue, fontSize: 15),
                    )),
                SizedBox(
                  height: 5,
                ),
                InkWell(
                    onTap: () async {
                      await makePhoneCall("tel:0660444051");
                    },
                    child: Text(
                      "06 60 44 40 51",
                      style: TextStyle(color: Colors.blue, fontSize: 15),
                    )),
                SizedBox(
                  height: 30,
                ),
                Text(
                  "E-mail:",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                InkWell(
                  onTap: () async {
                    await sendMail("contact@wasfaty-dz.com");
                  },
                  child: Text(
                    "contact@wasfaty-dz.com",
                    style: TextStyle(fontSize: 15, color: Colors.blue),
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                Text(
                  "Siteweb:",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                InkWell(
                  onTap: () async {
                    await openLink("https://www.wasfaty-dz.com");
                  },
                  child: Text(
                    "www.wasfaty-dz.com",
                    style: TextStyle(fontSize: 15, color: Colors.blue),
                  ),
                ),
              ],
            )),
            Padding(
              padding: const EdgeInsets.only(top: 10),
              child: Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    RaisedButton(
                      shape: RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.all(Radius.circular(20.0))),
                      color: Colors.redAccent.withOpacity(0.9),
                      child: Text(
                        'Fermer',
                        style: TextStyle(color: Colors.white),
                      ),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                  ]),
            ),
          ],
        );
      });
}
