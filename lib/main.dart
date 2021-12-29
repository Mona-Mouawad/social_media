import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_media/modules/Login.dart';
import 'package:social_media/modules/layout.dart';
import 'package:social_media/modules/onboarding_screen.dart';
import 'package:social_media/shared/bloc_observer.dart';
import 'package:social_media/shared/component.dart';
import 'package:social_media/shared/helper/cach_Helper.dart';
import 'package:social_media/shared/style/theme/theme.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

import 'cubit/LoginCubit.dart';
import 'cubit/RegisterCubit.dart';
import 'cubit/cubit.dart';

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  // If you're going to use other Firebase services in the background, such as Firestore,
  // make sure you call `initializeApp` before using other Firebase services.
  // await Firebase.initializeApp();
//Navigator.pushNamed(context!, routeName)
  print("Handling a background message: ${message.messageId}");
}

//BuildContext? context;
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Cach_helper.init();
  await Firebase.initializeApp();
  Bloc.observer = MyBlocObserver();
  uid = Cach_helper.GetData(key: 'uId') ?? '';
  bool onBparding = Cach_helper.GetData(key: 'onBparding') ?? false;
  Widget startwidget;

  FirebaseMessaging messaging = FirebaseMessaging.instance;
  token = (await messaging.getToken())!;
  print(token);
  print('===========================' + Timestamp.now().toString());

  FirebaseMessaging.onMessage.listen((event) {
    print(event.data.toString());
  });

  FirebaseMessaging.onMessageOpenedApp.listen((event) {
    print('event.data.toString()');
    print(event.data.toString());
  });

  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  if (onBparding) {
    startwidget = loginScreen();
  }

  if (uid != '') {
    startwidget = layout_screen();
  } else
    startwidget = OnbroadingScreen();

  runApp(MyApp(
    startwidget: startwidget,
  ));
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  final Widget? startwidget;

  MyApp({this.startwidget});

  @override
  Widget build(BuildContext context) {
    return
      MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (BuildContext context) => SocialCubit()
              ..getprofile()
              ..getPost()
              ..getAllusers()..getPostsIDs_User()
              ..getNotifications()..GetUserPostData(),
         ),
          BlocProvider(
            create: (BuildContext context) => Registercubit(),
          ),
          BlocProvider(
            create: (BuildContext context) => Logincubit(),
          ),
        ],
         child:
                MaterialApp(
                  debugShowCheckedModeBanner: false,
                  theme: lightTheme,
                  home: startwidget
                 ),
        );
  }
}
