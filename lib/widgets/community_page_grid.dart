import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/community_provider.dart';
import '../widgets/community_item.dart';

class CommunityPageGrid extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final confessionsData = Provider.of<Confessions>(context);
    final confessions = confessionsData.items;

    return GridView.builder(
      padding: const EdgeInsets.all(10.0),
      itemCount: confessions.length,
      itemBuilder: (ctx, i) => ChangeNotifierProvider.value(
        value: confessions[i],
        // create: (c) => products[i],
        child: CommunityItem(
            //   confessions[i].id,
            //   confessions[i].description,
            ),
      ),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 1,
        childAspectRatio: 5 / 2,
        crossAxisSpacing: 10,
        mainAxisSpacing: 15,
      ),
    );
  }
}
