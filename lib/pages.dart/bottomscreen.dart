import 'package:flutter/material.dart';
import 'package:riderapp/screens/bottomscreens/add_contacts.dart';
import 'package:riderapp/screens/bottomscreens/community_page.dart';
import 'package:riderapp/screens/bottomscreens/home_screen.dart';
import 'package:riderapp/screens/bottomscreens/sos_screen.dart';

class BottomPage extends StatefulWidget {
  const BottomPage({super.key});

  @override
  State<BottomPage> createState() => _BottomPageState();
}

class _BottomPageState extends State<BottomPage> {
  int currentIndex = 0;
  List<Widget> screens = [
    const HomeScreen(),
    const SosScreen(),
    const CommunityScreen(),
    const AddContactsPage(),
  ];
  onTapped(int index) {
    setState(() {
      currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: screens[currentIndex],
      bottomNavigationBar: BottomNavigationBar(
          currentIndex: currentIndex,
          type: BottomNavigationBarType.fixed,
          onTap: onTapped,
          items: const [
            BottomNavigationBarItem(
              label: 'Home',
              icon: Icon(Icons.home),
            ),
            BottomNavigationBarItem(
              label: 'SOS',
              icon: Icon(Icons.sos),
            ),
            BottomNavigationBarItem(
              label: 'Community',
              icon: Icon(Icons.groups),
            ),
            BottomNavigationBarItem(
              label: 'Contacts',
              icon: Icon(Icons.contacts_outlined),
            ),
          ]),
    );
  }
}
