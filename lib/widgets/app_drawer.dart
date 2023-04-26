import 'package:flutter/material.dart';

import '../screens/user_confessions_screen.dart';

class AppDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: <Widget>[
          AppBar(
            title: Text('Hello Friend!'),
            automaticallyImplyLeading: false,
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.home),
            title: Text('Home'),
            onTap: (() {
              Navigator.of(context).pushReplacementNamed('/');
            }),
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.edit),
            title: Text('Manage Posts'),
            onTap: (() {
              Navigator.of(context)
                  .pushReplacementNamed(UserConfessionsScreen.routeName);
            }),
          ),
        ],
      ),
    );
  }
}
