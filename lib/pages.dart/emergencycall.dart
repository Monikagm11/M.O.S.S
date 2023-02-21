import 'package:flutter/material.dart';

class emergencyCall extends StatefulWidget {
  const emergencyCall({super.key});

  @override
  State<emergencyCall> createState() => _emergencyCallState();
}

class _emergencyCallState extends State<emergencyCall> {
  @override
  Widget build(BuildContext context) {
    return Card(
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
            );
  }
}