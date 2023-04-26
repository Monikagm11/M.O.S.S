import 'package:flutter/material.dart';
import '../pages.dart/authentication/login_page.dart';
import '../pages.dart/authentication/registerpage.dart';



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