import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../pages.dart/registerpage.dart';
import 'forgotpasswordpage.dart';
//import '../Pages.dart/registerpage.dart';


class LoginPage extends StatefulWidget {
  static const routeName = "/login-page";
  //final VoidCallback showRegisterPage;
  //const LoginPage({key? key,required this.showRegisterPage}):super(key: key);
  //const LoginPage({Key? key,required this.showRegisterPage}):super(key: key);
  

  

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final email_controller=TextEditingController();
  final Password_controller=TextEditingController();

  Future signIn () async{
    await FirebaseAuth.instance.signInWithEmailAndPassword
    (email: email_controller.text.trim(),
     password: Password_controller.text.trim(),
     );
    

  }
  bool isPasswordShown=false; //for password visibility

  
  @override
  void dispose() {
    // TODO: implement dispose
    email_controller.dispose();
    Password_controller.dispose();
    super.dispose();
  }
  Widget build(BuildContext context) {
    return Scaffold(
      
      backgroundColor: Color.fromARGB(255, 138, 35, 156),
      body:SafeArea(
        child:Center(
          child:SingleChildScrollView(
          child:Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              //SizedBox(  //adds little space from the top
               // height:180 ,
             // ),
              

              
              Text(
                
                'M.O.S.S',
                style:TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 50,
                  color: Colors.white,
                  
                ),
                ),
                Text(
                'A Women Safety Application',
                style:TextStyle(
                  fontWeight: FontWeight.normal,
                  fontSize: 25,
                  color: Colors.white,
                  ),
                ),

                //email
                SizedBox(height: 40,),
                 Container(
                 padding:EdgeInsets.all(3) ,
                  width: 350,
                  decoration:BoxDecoration(
                    border:Border.all(color:Colors.white ) ,
                    borderRadius:BorderRadius.circular(12) ,
                    color:Colors.white ,
                    
                    //boxShadow:BoxShadow.lerp() ,

                  ) ,
             
                  
                  
                
               child: TextField(
                keyboardType: TextInputType.emailAddress,
                controller: email_controller,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: 'E-mail',
                    prefixIcon:Align(
                      heightFactor:1.0 ,
                      widthFactor:1.0 ,
                      child: Icon(Icons.email_outlined),
                       alignment:Alignment.centerLeft,
                      
                      )
                    
                    ),
                    ),
                 ),

                 //password
                  SizedBox(height: 10,),
                 Container(
                 padding:EdgeInsets.all(3) ,
                  width: 350,
                  decoration:BoxDecoration(
                    border:Border.all(color:Colors.white ) ,
                    borderRadius:BorderRadius.circular(12) ,
                    color:Colors.white ,
                    
                    ) ,
             
                   child: TextField(
                    controller:Password_controller ,
                    obscureText: isPasswordShown, //hide password
                    
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: 'Password',
                   // Password_controller:isPasswordShown,
                    prefixIcon:Align(
                      heightFactor:1.0 ,
                      widthFactor:1.0 ,
                      alignment:Alignment.centerLeft,
                      child: Icon(Icons.vpn_key),
                      
                      ),
                    suffixIcon: IconButton(
                    onPressed:() {
                      setState(() {
                        isPasswordShown =!isPasswordShown; 
                      });
                     
                    },
                     icon:isPasswordShown
                     ? Icon(Icons.visibility_off)
                     : Icon(Icons.visibility),
                     
                     ),
                    ),
                    ),
                 ),

                 SizedBox(height:10),

                 Padding(
                   padding: const EdgeInsets.symmetric(horizontal: 25.0),
                   child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,

                     children: [
                       GestureDetector(
                        onTap: () => 
                        Navigator.push(
                          context,
                           MaterialPageRoute(
                            builder: (context)  
                        {
                          return ForgotPasswordPage();
                          }
                        )
                        )
                        ,
                         child: Text(
                          'Forgot Password?',
                          style:TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.blue,
                            )),
                       ),
                     ],
                   ),
                 ),
                
                
                
                 SizedBox(
                  height: 30,
                 ),
                 //sign_in button
                  
                 
                  GestureDetector(
                    
                    onTap: signIn,
                    child: Container(
                    padding:EdgeInsets.all(15),
                    width: 350,
                    
                    
                    decoration: BoxDecoration(
                      border:Border.all(color: Colors.white) ,
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.white,
                    ),
                    child:Center(
                      child: Text(
                      'Sign In',
                      style:TextStyle(
                        color: Color.fromARGB(255, 200, 146, 255),
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ) ,
                      ),
                    ),
                    
                  
                                   ),
                  ),
                 //Not a member?Register now
                 SizedBox(height: 30,),
                 Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  //crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                    'Not a member?',
                    style:TextStyle(
                      fontWeight: FontWeight.bold,
                      color:Colors.white,
                    ),
                    ),

                    GestureDetector(
                      onTap: () => Navigator.of(context).pushNamed(RegisterPage.routeName) ,
                      child: Text(
                        'Register now',
                        style:TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.blue,
                        )),
                    )
                  ],

                 ),

                 
                


              
            ],
          ),

          
        ) ,
        ),
      ) ,

    );
  }
}