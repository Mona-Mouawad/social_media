import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:social_media/shared/style/colors/colors.dart';
ThemeData lightTheme=
   ThemeData(
        primarySwatch: Colors.purple,
        fontFamily: 'KaiseiTokumin',
        appBarTheme: AppBarTheme(
          color: Colors.white,
          elevation: 0,
          iconTheme: IconThemeData(color: defultcolor),
          backwardsCompatibility: false,
          titleTextStyle: TextStyle(
            color: defultcolor
          ),
          systemOverlayStyle: SystemUiOverlayStyle(
            statusBarIconBrightness: Brightness.dark,
            statusBarColor: Colors.white,
           )
        ),
        scaffoldBackgroundColor: Colors.white,
      );


ThemeData darkTheme= ThemeData(
        primarySwatch: Colors.blue,
        fontFamily: 'KaiseiTokumin',
        appBarTheme: AppBarTheme(
          color: HexColor('333739'),
          elevation: 5,
          iconTheme: IconThemeData(color: Colors.red[900]),
          backwardsCompatibility: false,
          titleTextStyle: TextStyle(
            color: defultcolor
          ),
          systemOverlayStyle: SystemUiOverlayStyle(
            statusBarIconBrightness: Brightness.light,
            statusBarColor: HexColor('333739')
          )
        ),
        scaffoldBackgroundColor: HexColor('333739'),
      );
     
