import 'package:flutter/material.dart';

class ambulanceEmergency extends StatefulWidget {
  const ambulanceEmergency({super.key});

  @override
  State<ambulanceEmergency> createState() => _ambulanceEmergencyState();
}

class _ambulanceEmergencyState extends State<ambulanceEmergency> {
  @override
  Widget build(BuildContext context) {
    return  Card(
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
                            title: Text("Ambulance"),
                            subtitle: Text("Call Ambulance Directly"),
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
            );
  }
}