import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:riderapp/screens/drawer_screens/laws/law_session.dart';
import 'package:riderapp/screens/drawer_screens/profile/user_page.dart';
import 'settings/settings.dart';
import '../../../screens/drawer_screens/about_us.dart';
import 'profile/user_profile.dart';
import '../../components/miscwidgets/divider.dart';

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
              const DividerWidget(),
              const SizedBox(
                height: 12,
              ),
              // Drawer body Controllers
              InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const LawSession()),
                  );
                },
                child: const ListTile(
                  leading: Icon(
                    Icons.policy,
                  ),
                  title: Text(
                    'Law Session',
                    style: TextStyle(
                      fontSize: 15.0,
                    ),
                  ),
                ),
              ),
              
              InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const UserPage()),
                  );
                },
                child: const ListTile(
                  leading: Icon(Icons.person),
                  title: Text(
                    'Visit Profile',
                    style: TextStyle(
                      fontSize: 15.0,
                    ),
                  ),
                ),
              ),
              I

              // ShakePage(),
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
