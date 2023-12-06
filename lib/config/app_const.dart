import 'package:flutter/material.dart';

class AppConst {
  static const String appName = "Tafeel";
  static const String baseUrl = "https://reqres.in/api/";
  static const String logoPath  = "assets/images/tafeel_logo.png";
  static ThemeData theme(context) =>  ThemeData(
        primaryColor: const Color(0xffA80533),
        colorScheme:  Theme.of(context).colorScheme.copyWith(secondary: const Color(0xffA18A00)),
        fontFamily: 'Cairo',
       
        //useMaterial3: true,
      );
}