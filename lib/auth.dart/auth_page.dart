import 'package:flutter/material.dart';
import 'package:moss_project/Pages.dart/login_page.dart';
import '../Pages.dart/registerpage.dart';



class AuthPage extends StatefulWidget {
  //const AuthPage({super.key});
  const AuthPage({Key? key}) : super(key: key);

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {

  bool showLoginPage=true;

  void toggleScreens(){
    setState(() {
      showLoginPage = !showLoginPage;
    });
    
  }
  @override
  Widget build(BuildContext context) {
    if (showLoginPage){
      return LoginPage();

    }
    else{
      return RegisterPage();
    }
  }
}