import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import '../authentication/login_page.dart';
import 'package:moss_project/auth.dart/actualpage.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    
    super.initState();
    Future.delayed(const Duration(seconds:6)).then((value) {
    Navigator.of(context).pushReplacement(
    MaterialPageRoute(builder:(ctx) =>  MainPage() ));
   }); 

  }
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      body:SizedBox(
        width:double.infinity,
        child:Container(
          color: Colors.white,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            //crossAxisAlignment: CrossAxisAlignment.end,
            children: const[
              Image(
                image: AssetImage("assets/logo.jpg"),
                fit: BoxFit.fitHeight,
                width: 400,
                height: 400,
                
                //height: double.infinity,
                ),

              SizedBox(height: 50,) ,
              SpinKitFadingCircle(
              color: Colors.purple,
              size: 50.0,
              
)
            ],
            ),
        )

      ),
    );
  }
}