import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/container.dart';

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({super.key});

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  final email_controller=TextEditingController();
  @override
  void dispose() {
    email_controller.dispose();
    super.dispose();
  }

  Future passwordReset() async{

    try{
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email_controller.text.trim());
       showDialog
      (context: context,
       builder: (context){
        return AlertDialog(
          content: Text('Password Reset Link Sent,Check Your Email'),
       );
    });

    }
    on FirebaseAuthException catch(e){
      print(e);
      showDialog
      (context: context,
       builder: (context){
        return AlertDialog(
          content: Text(e.message.toString()),
        );
       });
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar:AppBar(
        backgroundColor:Color.fromARGB(255, 143, 9, 167),
        elevation: 0,
      ) ,
      body:
       Column
      (
        
        mainAxisAlignment: MainAxisAlignment.start,
        children:[
          SizedBox(height: 30,),
         Padding(
           padding: const EdgeInsets.symmetric(horizontal: 25.0),
           child: Text(
            'Enter Your Email to get password reset link',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 20),
            selectionColor: Colors.black,
            ),
         ),
        
         //email 
          SizedBox(height: 10,),
                 Padding(
                  padding:EdgeInsets.symmetric(horizontal:25.0) ,
                   child: Container(
                
                    width: 350,
                    decoration:BoxDecoration(
                      border:Border.all(color:Colors.grey ) ,
                      borderRadius:BorderRadius.circular(12) ,
                      color:Colors.white ,
                      
                      //boxShadow:BoxShadow.lerp() ,

                    ) ,
             
                    
                    
                
               child: TextField(
                controller: email_controller,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: 'E-mail',
                      
                      ),
                      ),
                   ),
                 ),
                 SizedBox(height: 10),
               MaterialButton(onPressed: passwordReset,
                child:Text('Reset Password'),
                color:Colors.purple,

              )   
              ],
            
       
       ),
    );
  }
}