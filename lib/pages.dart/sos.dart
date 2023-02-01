//import 'dart:html';

import 'dart:ui';

import 'package:background_sms/background_sms.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
// import 'package:hardware_buttons/hardware_buttons.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:moss_project/auth.dart/main.dart';
import 'package:lite_rolling_switch/lite_rolling_switch.dart';
import 'package:moss_project/db.dart/dbservices.dart';
import 'package:moss_project/model.dart/contacts.dart';
import 'package:moss_project/pages.dart/gesture.dart';

import 'package:permission_handler/permission_handler.dart';
import '../component/PrimaryButton.dart';
import '../db.dart/dbservices.dart';
import '../Pages.dart/addcontacts.dart';

//import 'dart:html';
import 'package:intl/intl_standalone.dart';

class SafeHome extends StatefulWidget {
  @override
  State<SafeHome> createState() => _SafeHomeState();
}

class _SafeHomeState extends State<SafeHome> {
  Position? _curentPosition;
  String? _curentAddress;
  LocationPermission? permission;
 

  //  @override
  //  void initState(){
  //    super.initState();
  //    _getPermission();
  //    _getCurrentLocation();
  //  }

   final audioPlayer =AudioPlayer();
  bool isPlaying=false;
  Duration duration=Duration.zero;
  Duration position = Duration.zero;

   @override
  void initState(){
    super.initState();
    _getPermission();
     _getCurrentLocation();

    setAudio();
    //super.initState();
   

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

  // final player=AudioCache(prefix: 'assets/');
  // final url=await player.load('siren.mp3');
  // audioPlayer.setUrl(url.path inLocal:true);
  // }


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

 

  


  


  showModelSafeHome(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Container(
          height: MediaQuery.of(context).size.height / 2,
          child: Padding(
            padding: const EdgeInsets.all(14.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "SEND YOUR CUURENT LOCATION IMMEDIATELY TO YOU EMERGENCY CONTACTS",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 20),
                ),
                SizedBox(height: 10),
                if (_curentPosition != null) Text(_curentAddress!),
                PrimaryButton(
                    title: "GET LOCATION",
                    onPressed: () {
                      _getCurrentLocation();
                    }),
                SizedBox(height: 10),
                PrimaryButton(
                    title: "SEND ALERT",
                    onPressed: () async {
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
                    }),
              ],
            ),
          ),
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30),
                topRight: Radius.circular(30),
              )),
        );
      },
    );


    
  }

 

   EmergencyCall(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Container(
          height: MediaQuery.of(context).size.height / 2,
          child: Padding(
            padding: const EdgeInsets.all(14.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //crossAxisAlignment: CrossAxisAlignment.start,
                
                children: [
                  Text(
                    'Shake your phone to Call',
                    textAlign: TextAlign.start,
                    
                    style: TextStyle(fontSize: 23),
                    ),
                  LiteRollingSwitch(
                  value: false,
                  onChanged: (bool state) {
                    print('turned ${(state) ? 'on' : 'off'}');
                  },
                  width: 80,
                  iconOn: Icons.call,
                  iconOff: Icons.call,
                  colorOn: Colors.green,
                  colorOff: Colors.red,
                  onDoubleTap: () {},
                  onSwipe: () {},
                  onTap: () {
                   
                  },
            ),
                ],
              ),

            //Customized
            // Padding(
            //   padding: const EdgeInsets.only(top: 20),
            //   child: LiteRollingSwitch(
            //     value: true,
            //     width: 150,
            //     textOn: 'active',
            //     textOff: 'inactive',
            //     colorOn: Colors.deepOrange,
            //     colorOff: Colors.blueGrey,
            //     iconOn: Icons.lightbulb_outline,
            //     iconOff: Icons.power_settings_new,
            //     animationDuration: const Duration(milliseconds: 300),
            //     onChanged: (bool state) {
            //       print('turned ${(state) ? 'on' : 'off'}');
            //     },
            //     onDoubleTap: () {},
            //     onSwipe: () {},
            //     onTap: () {},
            //   ),
            // ),

            SizedBox(height: 80,),
                Text(
                  " Call Your Emergency Contacts ",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 23),
                ),
                SizedBox(height: 10),
                //if (_curentPosition != null) Text(_curentAddress!),
                
                PrimaryButton(
                    title: " Call ",
                    onPressed: () async {
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


                      //String recipients = "contactList";
                     //List<Tcontact> contactList =
                        //  await DatabaseHelper().getContactList();

                     
                       //if (await _isP\ermissionGranted()) {
                        //if((await _supportCustomSim)!)
                        //contactList.forEach((element) {
                          //FlutterPhoneDirectCaller.callNumber("${element.number}");
                        //});
                     /// } //else {
                        //_getPermission();
                       // Fluttertoast.showToast(msg: "something wrong");
                    // }
                    }
                    ),
                
              ],
            ),
          ),
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30),
                topRight: Radius.circular(30),
              )),
        );
      },
    );

    



 //  @override
  // void initState() {
  //   super.initState();
  //   WidgetsBinding.instance.addPostFrameCallback((_) => _overridePowerButton());
  // }
  //  }  
  

  // void _overridePowerButton() {
  //   _powerButtonPressCount++;
  //   if(_powerButtonPressCount == 5) {

  //     // Add your code here to handle the power button press
  //     EmergencyCall(context);
      

  //     _powerButtonPressCount = 0;
  //   }
  // }
  //  @override
  // void initState() {
  //   super.initState();
  //   WidgetsBinding.instance.addPostFrameCallback((_) => _overridePowerButton());
  // }
  //  }
   
  
 

 

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
          InkWell(
            onTap: () => showModelSafeHome(context),
             
            child: Card(
              elevation: 5,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              child: SizedBox(
                
                child: Container(
                  height: 80,
                  width: MediaQuery.of(context).size.width*0.95 ,
                  //decoration: BoxDecoration(),
                  child: Row(
                    children: [
                      Expanded(
                          child: Column(
                        children: [
                          ListTile(
                            title: Text("Send Location"),
                            subtitle: Text("Share Location"),
                          ),
                          

                        ],
                      )
                      ),
                      //ClipRRect(
                         // borderRadius: BorderRadius.circular(20),
                          //child: Image.asset('assets/route.jpg')),
                    ],
                  ),
                ),
              ),
            ),
            
          ),

        //  SecondaryButton(title: "Call Your Emergency Contacts", subtitle: "Call", onTap: EmergencyCall(context))
          InkWell(
            onTap: () => EmergencyCall(context),
             
            child: Card(
              elevation: 5,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              child: SizedBox(
                
                child: Container(
                  height: 80,
                  width: MediaQuery.of(context).size.width*0.95 ,
                  //decoration: BoxDecoration(),
                  child: Row(
                    children: [
                      Expanded(
                          child: Column(
                            
                        children: [
                          ListTile(
                            title: Text("Call Your Emergency Contacts"),
                            subtitle: Text("Call"),
                          ),
                          

                        ],
                      )
                      ),
                      //ClipRRect(
                         // borderRadius: BorderRadius.circular(20),
                          //child: Image.asset('assets/route.jpg')),
                    ],
                  ),
                ),
              ),
            ),
            
          ),
          InkWell(
            onTap: () => FalseAlarm(context),
             
            child: Card(
              elevation: 5,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              child: SizedBox(
                
                child: Container(
                  height: 80,
                  width: MediaQuery.of(context).size.width*0.95 ,
                  // decoration: BoxDecoration(
                  //   color: Colors.white
                  // ),
                  child: Row(
                    children: [
                      Expanded(
                          child: Column(
                            
                        children: [
                          ListTile(
                            
                            title: Text("S.O.S Siren"),
                            subtitle: Text("Set False Alarm"),
                          ),
                          

                        ],
                      )
                      ),
                      //ClipRRect(
                         // borderRadius: BorderRadius.circular(20),
                          //child: Image.asset('assets/route.jpg')),
                    ],
                  ),
                ),
              ),
            ),
            
          ),

          
         
         

         
          
        ],
      ),
      
       
    );
  }
}