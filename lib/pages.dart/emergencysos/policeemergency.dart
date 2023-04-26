import'package:flutter/material.dart';
class policeEmergency extends StatelessWidget {
  const policeEmergency({super.key});

  @override
  Widget build(BuildContext context) {
    return  Card(
             // color:Color.fromARGB(255, 255, 59, 59),
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
                     // Image.asset('assets/police-badge.png',),
                      Expanded(
                          child: Column(
                        children: [
                          ListTile(
                            title: Text("Police "),
                            subtitle: Text("Call Police Directly"),
                          ),
                          

                        ],
                      ),
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