import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:scoop/screens/home.dart';

void main() {

  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark.copyWith(
      statusBarColor: Colors.white, // Color for Android
      statusBarBrightness: Brightness.dark // Dark == white status bar -- for IOS.
  ));

  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: Home(),
  ));
}