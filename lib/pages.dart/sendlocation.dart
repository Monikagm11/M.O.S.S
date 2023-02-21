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