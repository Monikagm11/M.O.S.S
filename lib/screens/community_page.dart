import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../widgets/community_page_grid.dart';
import '../widgets/app_drawer.dart';

import '../providers/community_provider.dart';

class CommunityPage extends StatefulWidget {
  @override
  State<CommunityPage> createState() => _CommunityPageState();
}

class _CommunityPageState extends State<CommunityPage> {
  var _isInit = true;
  var _isLoading = false;

  @override
  void didChangeDependencies() {
    if (_isInit = true) {
      setState(() {
        _isLoading = true;
      });
      Provider.of<Confessions>(context).fetchAndSetConfessions();
      setState(() {
        _isLoading = false;
      });
    }
    _isInit = false;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: Text('Community Page'),
      // ),
      body: _isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : CommunityPageGrid(),
    );
  }
}
