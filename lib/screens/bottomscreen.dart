import 'package:flutter/material.dart';
import 'package:moss_project/law_code/law_session.dart';
import '../pages.dart/contactpage/addcontacts.dart';
import '../screens/community_page.dart';
import '../pages.dart/home/home_screen.dart';
import '../pages.dart/emergencysos/sos.dart';
import 'community_page.dart';

class BottomPage extends StatefulWidget {
  const BottomPage({super.key});

  @override
  State<BottomPage> createState() => _BottomPageState();
}

class _BottomPageState extends State<BottomPage> {
  int currentIndex = 0;
  List<Widget> screens = [
    const HomeScreen(),
    SafeHome(),
    CommunityPage(),
    const LawSession(),
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
              label: 'Law Session',
              icon: Icon(Icons.newspaper_rounded),
            ),
          ]),
    );
  }
}