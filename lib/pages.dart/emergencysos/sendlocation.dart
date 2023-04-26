import 'package:flutter/material.dart';

class sendLocation extends StatefulWidget {
  const sendLocation({super.key});

  @override
  State<sendLocation> createState() => _sendLocationState();
}

class _sendLocationState extends State<sendLocation> {
  @override
  Widget build(BuildContext context) {
    return Card(
              elevation: 5,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              child: SizedBox(
                
                child: Container(
                  height: 75,
                  width: MediaQuery.of(context).size.width*0.95 ,
                     decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Color.fromARGB(255, 201, 149, 209),Color.fromARGB(255, 231, 213, 231)],
                      begin:Alignment.topRight,
                      end:Alignment.bottomLeft,
                    ),
                    shape: BoxShape.rectangle,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                          child: Column(
                        children: [
                          ListTile(
                            title: Text("Send Location"),
                            subtitle: Text("Message Your Current Location To Emergency Contacts"),
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