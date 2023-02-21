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
                  height: 80,
                  width: MediaQuery.of(context).size.width*0.95 ,
                  //decoration: BoxDecoration(),
                  child: Row(
                    children: [
                      Expanded(
                          child: Column(
                        children: [
                          ListTile(
                            title: Text("Police "),
                            subtitle: Text("Call Police Directly"),
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