import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/community_provider.dart';

import '../widgets/user_confession_item.dart';
import '../widgets/app_drawer.dart';

import 'edit_confession_screen.dart';

class UserConfessionsScreen extends StatelessWidget {
  static const routeName = '/user-confessions';
  @override
  Widget build(BuildContext context) {
    final confessionsData = Provider.of<Confessions>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Your Confessions'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              Navigator.of(context).pushNamed(EditConfessionScreen.routeName);
            },
          ),
        ],
      ),
      drawer: AppDrawer(),
      body: Padding(
        padding: EdgeInsets.all(8),
        child: ListView.builder(
          itemCount: confessionsData.items.length,
          itemBuilder: (_, i) => Column(
            children: [
              UserConfessionItem(
                confessionsData.items[i].id,
                confessionsData.items[i].description,
              ),
              Divider(),
            ],
          ),
        ),
      ),
    );
  }
}
