import'package:flutter/material.dart';

class getLocation extends StatefulWidget {
  const getLocation({super.key});

  @override
  State<getLocation> createState() => _getLocationState();
}

class _getLocationState extends State<getLocation> {
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
                            title: Text("Get Location"),
                            subtitle: Text("Get Your Current Location"),
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