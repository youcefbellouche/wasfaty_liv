import 'dart:async';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class Rev_PushNotification {
  final FirebaseMessaging _fcm = FirebaseMessaging.instance;
  static StreamController<String> _messageStreamController =
      new StreamController.broadcast();
  static Stream<String> get messageStream => _messageStreamController.stream;
  static Future _backgroundHandler(RemoteMessage message) async {
    // print("message oooo ${message.data}");
    _messageStreamController.add(message.notification.title);
    return;
  }

  static Future _onMessageHandler(RemoteMessage message) async {
    // print("message oooo ${message.data}");
    _messageStreamController.add(message.notification.title);
  }

  static Future _onMessageOpenApp(RemoteMessage message) async {
    // print("message oooo ${message.data}");
    _messageStreamController.add(message.notification.title);
  }

  Future initialize() async {
    print(" this is test ${_fcm.app.toString()}");
    FirebaseMessaging.onBackgroundMessage(_backgroundHandler);
    FirebaseMessaging.onMessage.listen(_onMessageHandler);
    FirebaseMessaging.onMessageOpenedApp.listen(_onMessageOpenApp);
  }

  static closeStrams() {
    _messageStreamController.close();
  }
}
