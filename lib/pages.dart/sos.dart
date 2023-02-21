import 'dart:math';
import 'dart:ui';
import 'package:background_sms/background_sms.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:moss_project/auth.dart/main.dart';
import 'package:lite_rolling_switch/lite_rolling_switch.dart';
import 'package:moss_project/db.dart/dbservices.dart';
import 'package:moss_project/model.dart/contacts.dart';
import 'package:moss_project/pages.dart/ambulanceemergency.dart';
import 'package:moss_project/pages.dart/emergencycall.dart';
import 'package:moss_project/pages.dart/gesture.dart';
import 'package:moss_project/pages.dart/policeemergency.dart';
import 'package:moss_project/pages.dart/sendlocation.dart';
import 'package:moss_project/pages.dart/shake.dart';
import 'package:moss_project/pages.dart/sossiren.dart';
import 'package:permission_handler/permission_handler.dart';
import '../component/PrimaryButton.dart';
import '../db.dart/dbservices.dart';
import '../Pages.dart/addcontacts.dart';
import 'package:intl/intl_standalone.dart';
import 'package:sensors_plus/sensors_plus.dart';
import 'package:shake/shake.dart';
import 'package:flutter_switch/flutter_switch.dart';

import 'getlocation.dart';

class SafeHome extends StatefulWidget {
  @override
  State<SafeHome> createState() => _SafeHomeState();
}

class _SafeHomeState extends State<SafeHome> {
  Position? _curentPosition;
  String? _curentAddress;
  LocationPermission? permission;
  final audioPlayer =AudioPlayer();
  bool isPlaying=false;
  Duration duration=Duration.zero;
  Duration position = Duration.zero;
  bool status1 = false;
  var shakeThresholdGravity = 2.7;
  int mShakeTimestamp = DateTime.now().millisecondsSinceEpoch;
  int mShakeCount = 0;
  int shakeCountResetTime = 3000;

  int shakeSlopTimeMS = 500;
  int minimumShakeCount = 2 ;

   @override
  void initState(){
  super.initState();
  _getPermission();
  _getCurrentLocation();
   setAudio();
   
  
  
  onPause(){}

  // var shakeThresholdGravity = 2.7;
  // int mShakeTimestamp = DateTime.now().millisecondsSinceEpoch;
  // int mShakeCount = 0;
  // int shakeCountResetTime = 3000;

  // int shakeSlopTimeMS = 500;
  // int minimumShakeCount = 2 ;

  

   shakeGesture() {
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
          String recipients = "contactList";
                      

                      String messageBody =
                          "https://www.google.com/maps/search/?api=1&query=${_curentPosition!.latitude}%2C${_curentPosition!.longitude}. $_curentAddress";
                      if (await _isPermissionGranted()) {
                        //if((await _supportCustomSim)!)
                        contactList.forEach((element) {
                          _sendSms("${element.number}",
                              "I am in trouble $messageBody");
                        });
                      } else {
                        _getPermission();
                        Fluttertoast.showToast(msg: "something wrong");
                     }
       


            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Shaked ")));
          }
        }
      },
    );
  }

    
    shakeGesture();
   

    //listen to states:playing,paused,stopped
    audioPlayer.onPlayerStateChanged.listen((state){
      setState(() {
        isPlaying=state==PlayerState.playing;
      });
    });
    //listen to audio duration
    audioPlayer.onDurationChanged.listen((newDuration) { 
      setState(() {
        duration=newDuration;
      });

    //Listen to audio position
    audioPlayer.onPositionChanged.listen((newPosition){
      setState(() {
        position=newPosition;
      });

    });

    });
  }
  
  Future setAudio() async{
    //Repeat song when completed
    audioPlayer.setReleaseMode(ReleaseMode.loop);
  
  //load theaudio from url
  String url='https://mobcup.net/d/6o8nslkl/mp3';
  audioPlayer.setSourceUrl(url);
  }

   @override
  void dispose() {
    // TODO: implement dispose
    audioPlayer.dispose();
    super.dispose();
  }

  String formatTime(Duration duration){
    String twoDigits(int n) => n.toString().padLeft(2,'0');
    final hours=twoDigits(duration.inHours);
    final minutes =twoDigits(duration.inMinutes.remainder(60));
    final seconds= twoDigits(duration.inSeconds.remainder(60));

    return[
      if(duration.inHours>0) hours,
      minutes,
      seconds
    ].join(':');
  }

   FalseAlarm(BuildContext context){
    showModalBottomSheet(
      context: context, 
      builder: (context) {
        return Container(
           height: MediaQuery.of(context).size.height / 2,
           child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  " Play False Alarm ",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 20),
                ),
                SizedBox(height:20),
               
                 
                
                Slider(
                  min: 0,
                  max: duration.inSeconds.toDouble(),
                  value: position.inSeconds.toDouble(),
                  onChanged: (value)async{
                    final position=Duration(seconds: value.toInt());
                    await audioPlayer.seek(position);

                    //play audio if it was paused
                    await audioPlayer.resume();
                  },
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(formatTime(position)),
                      Text(formatTime(duration)),
                    ],
                  ),
                ),
                CircleAvatar(
                  radius: 35,
                  child: IconButton(
                    icon:Icon(
                      color:Colors.purple,
                      isPlaying? Icons.pause:Icons.play_arrow,
                    ),
                    iconSize: 50,
                    onPressed: () async{
                      if(isPlaying){
                        await audioPlayer.pause();
                      }
                      else{
                      
                      String url='https://mobcup.net/d/6o8nslkl/mp3';
                      
                       await audioPlayer.play(UrlSource(url));

                      }
                    },
                  ),
                ),
              ],),
                
                


        );
      
      }
      );
   }




  
  _getPermission() async => await [Permission.sms].request();
  _isPermissionGranted() async => await Permission.sms.status.isGranted;
  _sendSms(String phoneNumber, String message, {int? simSlot}) async {
    SmsStatus result = await BackgroundSms.sendMessage(
        phoneNumber: phoneNumber, message: message, simSlot:1);
    if (result == SmsStatus.sent) {
      print("Sent");
      Fluttertoast.showToast(msg: "send");
    } else {
      Fluttertoast.showToast(msg: "failed");
    }
  }

  _getCurrentLocation() async {
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      Fluttertoast.showToast(msg: "Location permissions are  denind");
      if (permission == LocationPermission.deniedForever) {
        Fluttertoast.showToast(
            msg: "Location permissions are permanently denind");
      }
    }
    Geolocator.getCurrentPosition(
            desiredAccuracy: LocationAccuracy.high,
            forceAndroidLocationManager: true)
        .then((Position position) {
      setState(() {
        _curentPosition = position;
        print(_curentPosition!.latitude);
        _getAddressFromLatLon();
      });
    }).catchError((e) {
      Fluttertoast.showToast(msg: e.toString());
    });
  }

  _getAddressFromLatLon() async {
    try {
      List<Placemark> placemarks = await placemarkFromCoordinates(
          _curentPosition!.latitude, _curentPosition!.longitude);

      Placemark place = placemarks[0];
      setState(() {
        _curentAddress =
            "${place.locality},${place.postalCode},${place.street},";
      });
    } catch (e) {
      Fluttertoast.showToast(msg: e.toString());
    }
  }
  
  sendcurrentlocation() async {
                      String recipients = "contactList";
                      List<Tcontact> contactList =
                          await DatabaseHelper().getContactList();

                      String messageBody =
                          "https://www.google.com/maps/search/?api=1&query=${_curentPosition!.latitude}%2C${_curentPosition!.longitude}. $_curentAddress";
                      if (await _isPermissionGranted()) {
                        //if((await _supportCustomSim)!)
                        contactList.forEach((element) {
                          _sendSms("${element.number}",
                              "I am in trouble $messageBody");
                        });
                      } else {
                        _getPermission();
                        Fluttertoast.showToast(msg: "something wrong");
                     }
                     // else{
                      //  _getPermission();
                      //}//
                    }

  _callNumber(String number) async {
    await FlutterPhoneDirectCaller.callNumber(number);
  }

   EmergencyCall() async {
                      List<Tcontact> contactList =
                          await DatabaseHelper().getContactList();

                      var status = await Permission.phone.status;
                      if (status.isGranted) {
  // make the call     
                      
                       contactList.forEach((element) {
                          FlutterPhoneDirectCaller.callNumber("${element.number}");
                        });
                                            }
                      var statuss = await Permission.phone.request();
                      if (statuss.isGranted) {
  // make the call
                     contactList.forEach((element) {
                     FlutterPhoneDirectCaller.callNumber("${element.number}");
                        });
                     } else {
                     Permission.phone.request();
  // show a message or handle the case when the permission is not granted
                    showDialog(context: context, builder: (context)=> AlertDialog(
                       
                       content: Text("can't call"),
                       ));
                            }
                    }


       
     
   


  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
       backgroundColor: Color.fromARGB(255, 143, 9, 167),
       
        ),
      body: Column(
        children: [
       
          SizedBox(height: 20.0),

          //to get current location
          InkWell(
            onTap:()=> _getCurrentLocation(),
           // onTap:()=>,
            child: getLocation(),
            ),
          //to send current location directly through message to trusted contacts
          InkWell(
            onTap: () => sendcurrentlocation(),
            child: sendLocation(),
            ),
          //to make direct emergency call to trusted contacts
          InkWell(
            onTap: () => EmergencyCall(),
            
            child: emergencyCall(),
          ),
          //to call police
          InkWell(
            onTap: () =>_callNumber('100') ,
            child: policeEmergency(),
          ),
          //to call ambulance
          InkWell(
            onTap: () =>_callNumber('112') ,
            child: ambulanceEmergency(),
          ),
          //to play false alarm
          InkWell(
            onTap: () => FalseAlarm(context),
            child: sosSiren(),
          ),
          ],
      ),
      );
  }
}