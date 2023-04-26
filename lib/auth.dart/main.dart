import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:moss_project/screens/bottomscreen.dart';
//import 'package:moss_project/pages.dart/gesture.dart';
import 'package:moss_project/pages.dart/home/home_screen.dart';
import '../pages.dart/emergencysos/shake.dart';
import 'package:moss_project/pages.dart/emergencysos/sos.dart';
import 'package:moss_project/pages.dart/authentication/splashscreen.dart';
import 'package:moss_project/pages.dart/profilepage/trustedContactPage.dart';
import '../pages.dart/home/voice_cmd.dart';
//import'../Auth.dart/auth_page.dart';
import '../pages.dart/home/home_page.dart';
import 'package:flutter/material.dart';
import '../auth.dart/actualpage.dart';
import 'package:moss_project/pages.dart/authentication/registerpage.dart';
import '../pages.dart/authentication/login_page.dart';
import 'package:get/get.dart';
import'package:workmanager/workmanager.dart';
import 'package:provider/provider.dart';
//import 'package:background_fetch/background_fetch.dart';
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
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
      //home:const VoiceCommand(),
     // home:BottomPage(),
      
      //home:TrustedContactPage(),
      //home:SafeHome(),
      //home:Shake(),

      routes: {
        RegisterPage.routeName:(ctx) => RegisterPage(),
        LoginPage.routeName:(ctx) => LoginPage(),
      },

    );
  }
}

