library shake;

import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shake/shake.dart';
import '../db.dart/dbservices.dart';
import '../model.dart/contacts.dart';


class Gesture extends StatefulWidget {
  @override
  _GestureState createState() => _GestureState();
}

class _GestureState extends State<Gesture> {

int shakeCount = 0;
int minimumShakes = 3;

void onShake() {
  shakeCount++;
  if (shakeCount >= minimumShakes) {
    // Perform desired action
    shakeCount = 0;
  }
}
  
  @override
  void initState() {
    super.initState();
    ShakeDetector detector = ShakeDetector.autoStart(
      onPhoneShake: () async{
         onShake();
        List<Tcontact> contactList = await DatabaseHelper().getContactList();

        var status = await Permission.phone.status;
        if (status.isGranted) {
          if (mounted) {
             contactList.forEach((element) {
            FlutterPhoneDirectCaller.callNumber("${element.number}");
          });
          }
          
        } else {
          var statuss = await Permission.phone.request();
          if (statuss.isGranted) {
            contactList.forEach((element) {
              FlutterPhoneDirectCaller.callNumber("${element.number}");
            });
          } else {
            Permission.phone.request();
            showDialog(
              context: context,
              builder: (context) => AlertDialog(
                content: Text("Can't call"),
              ),
            );
          }
        }

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Shake!'),
          ),
           

                      
        );
        // Do stuff on phone shake
        
      },
     
      shakeSlopTimeMS: 500,
      shakeCountResetTime: 3000,
      shakeThresholdGravity: 2.7,
    );

    // To close:
     //detector.stopListening();
    // ShakeDetector.waitForStart() waits for user to call detector.startListening();
  }




  

  @override
  Widget build(BuildContext context) {
    return const Scaffold();
  }
}