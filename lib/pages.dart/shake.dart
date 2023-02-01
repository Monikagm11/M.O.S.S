import 'dart:math';

import 'package:flutter/material.dart';
import 'package:sensors_plus/sensors_plus.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shake/shake.dart';
import '../db.dart/dbservices.dart';
import '../model.dart/contacts.dart';

class Shake extends StatefulWidget {
  const Shake({super.key});

  @override
  State<Shake> createState() => _ShakeState();
}



class _ShakeState extends State<Shake> {



 @override
  void initState() {
    startListening();
    super.initState();
  }

  
  onPause(){}

  var shakeThresholdGravity = 2.7;
  int mShakeTimestamp = DateTime.now().millisecondsSinceEpoch;
  int mShakeCount = 0;
  int shakeCountResetTime = 3000;

  int shakeSlopTimeMS = 500;
  int minimumShakeCount = 2 ;



  void startListening() {
    accelerometerEvents.listen(
      (AccelerometerEvent event) async {
        double x = event.x;
        double y = event.y;
        double z = event.z;

        double gX = x / 9.80665;
        double gY = y / 9.80665;
        double gZ = z / 9.80665;

        // gForce will be close to 1 when there is no movement.
        double gForce = sqrt(gX * gX + gY * gY + gZ * gZ);

        if (gForce > shakeThresholdGravity) {
          var now = DateTime.now().millisecondsSinceEpoch;
          // ignore shake events too close to each other (500ms)
          if (mShakeTimestamp + shakeSlopTimeMS > now) {
            return;
          }

          // reset the shake count after 3 seconds of no shakes
          if (mShakeTimestamp + shakeCountResetTime < now) {
            mShakeCount = 0;
          }

          mShakeTimestamp = now;
          mShakeCount++;

        if (mShakeCount == minimumShakeCount) {
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



            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Shaked ")));
          }
        }
      },
    );
  }

  

  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(

      ),
    );
  }
}