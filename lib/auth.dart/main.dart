import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:moss_project/pages.dart/gesture.dart';
import 'package:moss_project/pages.dart/shake.dart';
import 'package:moss_project/pages.dart/sos.dart';
import 'package:moss_project/pages.dart/splashscreen.dart';
import 'package:moss_project/pages.dart/trustedContactPage.dart';
//import'../Auth.dart/auth_page.dart';
import '../Pages.dart/home_page.dart';
import 'package:flutter/material.dart';
import 'package:moss_project/Pages.dart/actualpage.dart';
import 'package:moss_project/pages.dart/registerpage.dart';
import '../Pages.dart/login_page.dart';
//import 'dart:html';
//import 'package:intl/intl_standalone.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp( const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      //home: SplashScreen(),
      //home:TrustedContactPage(),
      //home:SafeHome(),
      home:Shake(),

      routes: {
        RegisterPage.routeName:(ctx) => RegisterPage(),
        LoginPage.routeName:(ctx) => LoginPage(),
      },

    );
  }
}

