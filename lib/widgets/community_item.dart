import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/confession.dart';

class CommunityItem extends StatelessWidget {
  // final String id;
  // final String description;

  // CommunityItem(
  //   this.id,
  //   this.description,
  // );

  @override
  Widget build(BuildContext context) {
    final confession = Provider.of<Confession>(context, listen: false);
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: GridTile(
        child: Card(
          child: Text(confession.description),
        ),
        // child: GestureDetector(
        //   onTap: () {
        //     Navigator.of(context).pushNamed(
        //       CommunityScreen.routeName,
        //       arguments: id,
        //     );
        //   },
        //   child: Image.network(
        //     discription,
        //     fit: BoxFit.cover,
        //   ),
        // ),

        footer: GridTileBar(
          backgroundColor: Colors.black87,
          leading: Consumer<Confession>(
            builder: (ctx, confession, _) => IconButton(
              icon: Icon(
                  confession.isLiked ? Icons.favorite : Icons.favorite_border),
              onPressed: () {
                confession.toggleLikedStatus();
              },
              color: Theme.of(context).accentColor,
            ),
          ),
          trailing: IconButton(
            icon: Icon(Icons.comment),
            onPressed: () {
              //addcomment
            },
            // color: Theme.of(context).accentColor,
          ),
        ),
      ),
    );
  }
}
