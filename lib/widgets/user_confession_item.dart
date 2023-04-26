import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/community_provider.dart';

import '../screens/edit_confession_screen.dart';

class UserConfessionItem extends StatelessWidget {
  final String id;
  final String description;

  UserConfessionItem(this.id, this.description);

  @override
  Widget build(BuildContext context) {
    final scaffold = ScaffoldMessenger.of(context);
    return ListTile(
      title: Text(description),
      //leading: Text(description),
      // leading: CircleAvatar(
      //   backgroundImage: NetworkImage(imageUrl),
      // ),
      trailing: Container(
        width: 100,
        child: Row(
          children: <Widget>[
            IconButton(
              icon: Icon(Icons.edit),
              onPressed: () {
                Navigator.of(context)
                    .pushNamed(EditConfessionScreen.routeName, arguments: id);
              },
              color: Theme.of(context).primaryColor,
            ),
            IconButton(
              icon: Icon(Icons.delete),
              onPressed: () async {
                try {
                  Provider.of<Confessions>(context, listen: false)
                      .deleteConfession(id);
                } catch (error) {
                  scaffold.showSnackBar(
                    SnackBar(
                      content: Text(
                        'Deleting failed!',
                        textAlign: TextAlign.center,
                      ),
                    ),
                  );
                }
              },
              color: Theme.of(context).errorColor,
            ),
          ],
        ),
      ),
    );
  }
}
