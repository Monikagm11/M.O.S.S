import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../Pages.dart/login_page.dart';


class RegisterPage extends StatefulWidget {
  static const routeName = "/register-page";
  //final VoidCallback showLoginPage;
  //const RegisterPage({key,required this.showloginpage}):super(key: key);
 // const RegisterPage({Key? key,required this.showLoginPage}):super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  //text controllers
  final firstname_controller=TextEditingController();
  final lastname_controller=TextEditingController();
  final number_controller=TextEditingController();
  final email_controller=TextEditingController();
  final Password_controller=TextEditingController();
  final Confirmpassword_controller =TextEditingController();
  Color primaryColor=Color.fromARGB(255, 170, 45, 192);
  
  

  void dispose() {
    // TODO: implement dispose
    firstname_controller.dispose();
    lastname_controller.dispose();
    number_controller.dispose();
    email_controller.dispose();
    Password_controller.dispose();
    Confirmpassword_controller.dispose();
    super.dispose();
  }

  Future signUp() async{
  if (passwordConfirmed()) 
  {
    //creates user
     await FirebaseAuth.instance.createUserWithEmailAndPassword
   (email:email_controller.text.trim() ,
    password:Password_controller.text.trim(),
     );
     
   
    //add user details
    addUserDetails(
       firstname_controller.text.trim(),
       lastname_controller.text.trim(),
       number_controller.text.trim(),
       email_controller.text.trim(),

      
    );

    
     
  }

  }

  Future addUserDetails(String firstname_controller ,String lastname_controller,String number_controller,String email_controller) async{
    await FirebaseFirestore.instance.collection('users').add({
      'First Name':firstname_controller,
      'Last Name':lastname_controller,
      'Phone No.':number_controller,
      'Email':email_controller,
    });

  }
  bool passwordConfirmed(){
    if (Password_controller.text.trim()== Confirmpassword_controller.text.trim())
    {
      return true;
      


    }
    else{
      return false;
    }
    

    
  }

  bool isPasswordShown =false; //visibility of password
  bool passwordShown=false; //visibility of confirm password
  
  @override
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
                
                'Hello Again!',
                style:TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 50,
                  color: Colors.white,
                  
                ),
                ),
                Text(
                'Register Here With Your Details',
                style:TextStyle(
                  fontWeight: FontWeight.normal,
                  fontSize: 25,
                  color: Colors.white,
                  ),
                ),
                SizedBox(height: 40,),

                //full name
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
                    controller:firstname_controller,
                    
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: 'First Name',
                   prefixIcon:Align(
                      heightFactor:1.0 ,
                      widthFactor:1.0 ,
                      child: Icon(Icons.person),
                       alignment:Alignment.centerLeft,
                      
                      )
                    ),
                    ),
                 ),

                 //last name
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
                    controller:lastname_controller,
                    
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: 'Last Name',
                    prefixIcon:Align(
                      heightFactor:1.0 ,
                      widthFactor:1.0 ,
                      child: Icon(Icons.person),
                       alignment:Alignment.centerLeft,
                      
                      )
                    ),
                    ),
                 ),

                 //address

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
                    keyboardType:TextInputType.number,
                    controller:number_controller,
                    
                  decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: 'Enter your current number',
                  prefixIcon:Align(
                      heightFactor:1.0 ,
                      widthFactor:1.0 ,
                      child: Icon(Icons.phone),
                       alignment:Alignment.centerLeft,
                       ),
                  
                       

                    ),
                    ),
                 ),

                //email
                SizedBox(height: 10,),
                 Container(
                 padding:EdgeInsets.all(3) ,
                  width: 350,
                  decoration:BoxDecoration(
                    border:Border.all(color:Colors.white ) ,
                    borderRadius:BorderRadius.circular(12) ,
                    color:Colors.white ,
                    
                    //boxShadow:BoxShadow.lerp() ,

                  ) ,

                  //address
                  
             
                  
                  
                
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
                    prefixIcon:Align(
                      heightFactor:1.0 ,
                      widthFactor:1.0 ,
                      child: Icon(Icons.vpn_key),
                       alignment:Alignment.centerLeft,
                      
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
               


                //confirm password
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
                    controller:Confirmpassword_controller,
                    obscureText: passwordShown, //hide password
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: 'Confirm Password',
                    prefixIcon:Align(
                      heightFactor:1.0 ,
                      widthFactor:1.0 ,
                      child: Icon(Icons.vpn_key),
                       alignment:Alignment.centerLeft,
                      
                      ),
                       suffixIcon: IconButton(
                    onPressed:() {
                      setState(() {
                        passwordShown =!passwordShown; 
                      });
                     
                    },
                     icon:passwordShown
                     ? Icon(Icons.visibility_off)
                     : Icon(Icons.visibility),
                     
                     ),
                    ),
                    ),
                 ),
                

               
                  SizedBox(
                  height: 30,
                 ),
                 
                 
                 //sign_in button
                  
                 
                  GestureDetector(
                    onTap: signUp,
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
                      'Sign Up',
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
                    'Already Member?',
                    style:TextStyle(
                      fontWeight: FontWeight.bold,
                      color:Colors.white,
                    ),
                    ),
                    GestureDetector(
                      onTap: () =>Navigator.of(context).pushNamed(LoginPage.routeName) ,
                      child: Text(
                        'Login now',
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