import 'package:flutter/material.dart';

class BottomBarHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: const Text('Bottom App Bar'),
      ),
      body: new Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          new OutlineButton(
            child: const Text('Bottom App Bar'),
            onPressed: () => Navigator.pushNamed(context, '/bottom_app_bar'),
          ),
          new OutlineButton(
            child: const Text('Google Tasks Bottom bar'),
            onPressed: () =>
                Navigator.pushNamed(context, '/bottom_app_bar_google'),
          ),
        ],
      ),
    );
  }
}

class BottomAppBarPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(title: const Text('Bottom App Bar')),
      // floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: new FloatingActionButton(
        child: new Icon(Icons.add),
        onPressed: () {},
      ),
      bottomNavigationBar: new BottomAppBar(
        // hasNotch: true,
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