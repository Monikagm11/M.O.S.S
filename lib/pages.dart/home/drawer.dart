import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../../law_code/law_session.dart';
import '../profilepage/user_profile.dart';


class DrawerWidget extends StatelessWidget {
  DrawerWidget({super.key});
  final user = FirebaseAuth.instance.currentUser!;

  final firstname = FirebaseAuth.instance.currentUser!.displayName;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: 255.0,
        child: Drawer(
          child: ListView(
            children: [
              // Drawer header
              SizedBox(
                height: 165.0,
                child: DrawerHeader(
                  child: Row(
                    children: [

                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            '$firstname',
                            style: const TextStyle(fontFamily: 'Brand Bold'),
                          ),
                          const SizedBox(
                            height: 6,
                          ),
                          InkWell(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const UserProfile()),
                                );
                              },
                              child: const Text('Visit Profile')),
                        ],
                      )
                    ],
                  ),
                ),
              ),
             
              const SizedBox(
                height: 12,
              ),
          
              const ListTile(
                leading: IconButton(
                  onPressed: signUserOut,
                  icon: Icon(Icons.logout),
                ),
                title: Text(
                  'LOGOUT',
                  style: TextStyle(
                    fontSize: 15.0,
                  ),
                ),
              ),
            ],
          ),
        ));
  }
}

void signUserOut() {
  FirebaseAuth.instance.signOut();
}