import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:store_app/screens/main_widgets/drawer.dart';

class DROAppBar extends StatefulWidget {
  final String headText;
  const DROAppBar(this.headText);

  @override
  _DROAppBar createState() => _DROAppBar();
}

class _DROAppBar extends State<DROAppBar> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        key: _scaffoldKey,
      drawer:DroDrawer(),
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: new IconButton(
          icon: new Icon(Icons.menu, color: Colors.red,),
          onPressed: () => _scaffoldKey.currentState.openDrawer(),
        ),
        primary: false,
        title: TextField(
            decoration: InputDecoration(
                hintText: "Search",
                border: InputBorder.none,
                hintStyle: TextStyle(color: Colors.grey))),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.search, color: Colors.red), onPressed: () {},),
          IconButton(icon: Icon(Icons.notifications, color: Colors.red),
            onPressed: () {},)
        ],
      ),
    );
  }

}