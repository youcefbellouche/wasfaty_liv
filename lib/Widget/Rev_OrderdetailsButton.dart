import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class Rev_OrderdetailsButton extends StatelessWidget {
  String? label;
  String? info;
  bool localisation;
  double? lat;
  double? long;
  String? phone;
  Rev_OrderdetailsButton(
      {this.label,
      this.info,
      required this.localisation,
      this.phone,
      this.lat,
      this.long});
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(children: [
        Text(
          this.label!,
          textAlign: TextAlign.left,
          style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
        ),
        Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
                color: Theme.of(context).primaryColor,
                height: 35,
                width: MediaQuery.of(context).size.width * 0.9,
                child: Center(
                  child: TextButton(
                    child: Text(
                      this.info!,
                      style: TextStyle(
                          color: Colors.lightBlueAccent,
                          fontWeight: FontWeight.bold),
                    ),
                    onPressed: () async {
                      if (phone != null) {
                        await _makePhoneCall("tel:${this.phone}");
                      } else if (localisation) {
                        await _launchUniversalLinkIos(
                            'https://www.google.com/maps/@${this.long},${this.lat},12z');
                      }
                    },
                  ),
                ))),
      ]),
    );
  }

  Future<void> _makePhoneCall(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  Future<void> _launchUniversalLinkIos(String url) async {
    if (await canLaunch(url)) {
      final bool nativeAppLaunchSucceeded = await launch(
        url,
        forceSafariVC: false,
        universalLinksOnly: true,
      );
      if (!nativeAppLaunchSucceeded) {
        await launch(
          url,
          forceSafariVC: true,
        );
      }
    }
  }
}
