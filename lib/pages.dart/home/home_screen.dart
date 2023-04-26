import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'drawer.dart';

import '../emergencysos/live_safe.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final home = TextEditingController();
  final work = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Welcome'),
        backgroundColor: Color.fromARGB(255, 170, 78, 184),
      ),
      drawer: DrawerWidget(),
      body:
          //  SafeArea(
          // child:
          SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(children: [
            Container(
              padding: const EdgeInsets.all(8),
              child: TextField(
                key: const Key("text1"),
                controller: home,
                decoration: const InputDecoration(
                  prefixIcon: Icon(Icons.home),
                  border: OutlineInputBorder(),
                  hintText: 'Home Address',
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.all(8),
              child: TextField(
                key: const Key("text2"),
                controller: work,
                decoration: const InputDecoration(
                  prefixIcon: Icon(Icons.work),
                  border: OutlineInputBorder(),
                  hintText: 'Work Address',
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomRight,
              child: ElevatedButton(
                onPressed: () async {
                  String homeAddress = home.text;
                  String workAddress = work.text;
                  String url =
                      "https://www.google.com/maps/dir/?api=1&origin=$homeAddress&destination=$workAddress";
                  if (await canLaunch(url)) {
                    await launch(url);
                  } else {
                    throw 'Could not launch $url';
                  }
                },
                child: const Text("Take a Look!"),
              ),
            ),
            const Align(
              alignment: Alignment.topLeft,
              child: Text(
                "Explore",
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const LiveSafe(),
            const SizedBox(
              height: 10,
            ),
          ]),
        ),
      ),
    );
  }
}