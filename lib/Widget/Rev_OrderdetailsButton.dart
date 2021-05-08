import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class Rev_OrderdetailsButton extends StatelessWidget {
  String? label;
  String? info;
  String? url;
  String? phone;
  Rev_OrderdetailsButton({this.label, this.info, this.url, this.phone});
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
                          color: Colors.lightBlueAccent,fontWeight: FontWeight.bold),
                    ),
                    onPressed: () async {
                      if (phone != null) {
                        await _makePhoneCall("tel:${this.phone}");
                      }
                      if (url != null) {
                        await _launchUniversalLinkIos(this.url!);
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
