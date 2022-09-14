import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:http/http.dart';

const AndroidNotificationChannel channel = AndroidNotificationChannel(
  'my_channel', // id
  'My Channel', // title
  importance: Importance.max,
);
 const serverToken="AAAAs1sgrLo:APA91bE-FZQiwck_TLgzmLcRjI2BJxJQVTrekbaxdDNShfk7Rqpb2w10hwWB2CL_Q89wYGJqopXKpqbl-6bj783V-SPil3wK3uo5OAxL58YrU2vbFWQUi06mNnW8-vanqnRCwbAr6kvh";

class Notifications {
  static Future init() async {
    //await Firebase.initializeApp();
    print("started");
    final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

    await flutterLocalNotificationsPlugin.resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()?.createNotificationChannel(channel);

// initialise the plugin. app_icon needs to be a added as a drawable resource to the Android head project
    const AndroidInitializationSettings initializationSettingsAndroid = AndroidInitializationSettings('@drawable/icon');
    final IOSInitializationSettings initializationSettingsIOS = IOSInitializationSettings();

    final InitializationSettings initializationSettings = InitializationSettings(
        android: initializationSettingsAndroid,
        iOS: initializationSettingsIOS
    );
    await flutterLocalNotificationsPlugin.initialize(initializationSettings);

    await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print("message recieved ${message.data}");
      RemoteNotification notification = message.notification!;
      AndroidNotification? android = message.notification!.android;
      if (notification != null && android != null) {
        flutterLocalNotificationsPlugin.show(
            notification.hashCode,
            notification.title,
            notification.body,
            NotificationDetails(
              android: AndroidNotificationDetails(
                channel.id,
                channel.name,
              ),
            ));
      }
    });
  }
  void onDidReceiveLocalNotification(int id, String title, String body, String payload) async {
    // display a dialog with the notification details, tap ok to go to another page
    print("notification recieved");
  }

  static Future sendNotification(String userToken,title,body,type,userId,subjectId,action) async{
    String url='https://fcm.googleapis.com/fcm/send';
    Uri myUri = Uri.parse(url);
    await post(
      myUri,
      headers: <String, String>{
        'Content-Type': 'application/json',
        'Authorization': 'key=$serverToken',
      },
      body: jsonEncode(
        <String, dynamic>{
          'notification': <String, dynamic>{
            'body': body,
            'title': title
          },

          'data': <String, dynamic>{
            'type': type,
            'id': subjectId,
            'status': 'done'
          },
          'to': "$userToken",
        },
      ),
    ).whenComplete(()  {
      FirebaseFirestore.instance.collection("notifications").add({
        'timestamp':DateTime.now().millisecondsSinceEpoch,
        'body':body,
        'title':title,
        'type':type,
        'userId':userId,
        'subjectId':subjectId,
        'senderId':FirebaseAuth.instance.currentUser!.uid,
        'isRead':false,
        'action':action,
      });

    });
  }
}


class NotificationType{
  static final post="POST";
  static final profile="PROFILE";
  static final rejectedEvent="REQUEST_REJECTED";
  static final eventRequest="EVENT_REQUEST";
}