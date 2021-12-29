//
// import 'dart:convert';
//
// import 'package:firebase_messaging/firebase_messaging.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/foundation.dart';
// import 'package:http/http.dart' as http;
//
// int _messageCount = 0;
// String constructFCMPayload(String? token) {
//   _messageCount++;
//   return jsonEncode({
//     'token': token,
//     'data': {
//       'via': 'FlutterFire Cloud Messaging!!!',
//       'count': _messageCount.toString(),
//     },
//     'notification': {
//       'title': 'Hello FlutterFire!',
//       'body': 'This notification (#$_messageCount) was created via FCM!',
//     },
//   });
// }
// String _token='';
// Future<void> sendPushMessage() async {
//   if (_token == null) {
//     print('Unable to send FCM message, no token exists.');
//     return;
//   }
//
//   try {
//     await http.post(
//       Uri.parse('https://api.rnfirebase.io/messaging/send'),
//       headers: <String, String>{
//         'Content-Type': 'application/json; charset=UTF-8',
//       },
//       body: constructFCMPayload(_token),
//     );
//     print('FCM request for device sent!');
//   } catch (e) {
//     print(e);
//   }
// }
//
// Future<void> onActionSelected(String value) async {
//   switch (value) {
//     case 'subscribe':
//       {
//         print(
//           'FlutterFire Messaging Example: Subscribing to topic "fcm_test".',
//         );
//         await FirebaseMessaging.instance.subscribeToTopic('fcm_test');
//         print(
//           'FlutterFire Messaging Example: Subscribing to topic "fcm_test" successful.',
//         );
//       }
//       break;
//     case 'unsubscribe':
//       {
//         print(
//           'FlutterFire Messaging Example: Unsubscribing from topic "fcm_test".',
//         );
//         await FirebaseMessaging.instance.unsubscribeFromTopic('fcm_test');
//         print(
//           'FlutterFire Messaging Example: Unsubscribing from topic "fcm_test" successful.',
//         );
//       }
//       break;
//     case 'get_apns_token':
//       {
//         if (defaultTargetPlatform == TargetPlatform.iOS ||
//             defaultTargetPlatform == TargetPlatform.macOS) {
//           print('FlutterFire Messaging Example: Getting APNs token...');
//           String? token = await FirebaseMessaging.instance.getAPNSToken();
//           print('FlutterFire Messaging Example: Got APNs token: $token');
//         } else {
//           print(
//             'FlutterFire Messaging Example: Getting an APNs token is only supported on iOS and macOS platforms.',
//           );
//         }
//       }
//       break;
//     default:
//       break;
//   }
// }