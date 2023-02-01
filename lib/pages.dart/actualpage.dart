import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:moss_project/pages.dart/login_page.dart';

import '../auth.dart/auth_page.dart';
import '../Pages.dart/addcontacts.dart';
//import '../Pages.dart/login_page.dart';


import '../Pages.dart/home_page.dart';



class MainPage extends StatelessWidget {
  //const MainPage({super.key});
  const MainPage({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Scaffold(
     body:StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges() ,
      builder: (context, snapshot) 
      {
        if (snapshot.hasData)
        {
          var title;
          //return SOSMethods();
          return AddContactsPage();
          }
        //{return LoginPage();}
        else{
          return const AuthPage();
        }
      },)
    );
  }
}