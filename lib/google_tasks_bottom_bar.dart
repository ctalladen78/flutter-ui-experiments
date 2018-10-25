import 'package:flutter/material.dart';

class GoogleTasksBottomAppBarPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(title: const Text('Tasks - Bottom App Bar')),
      floatingActionButton: new FloatingActionButton(
        elevation: 4.0,
        child: new Row(children: <Widget>[
          new Icon(Icons.add),
          new Text('Add a task'),
        ],),
        onPressed: (){},
      ),
      // floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: new BottomAppBar(
        // hasNotch: false,
        child: new Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            new IconButton(
              icon: new Icon(Icons.menu),
              onPressed: () {},
            ),
            new IconButton(
              icon: new Icon(Icons.search),
              onPressed: () {},
            )
          ],
        ),
      ),
    );
  }
}