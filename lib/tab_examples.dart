import 'package:flutter/material.dart';

class FirstPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Container(
      child: new Center(
        child: new Icon(Icons.star,  size: 100.0, color:
        Colors.brown)
      )
    );
  }
}

class SecondPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Container(
      child: new Center(
        child: new Icon(Icons.favorite,  size: 100.0, color:
        Colors.brown)
      )
    );
  }
}

class ThirdPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Container(
      child: new Center(
        child: new Icon(Icons.person,  size: 100.0, color:
        Colors.brown)
      )
    );
  }
}


class MyTabs extends StatefulWidget {
  @override
  MyTabsState createState() => new MyTabsState();
}

class MyTabsState extends State<MyTabs> with SingleTickerProviderStateMixin  {

  TabController _controller;

  @override
  void initState() {
    super.initState();
    _controller = new TabController(vsync: this, length: 3);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  _buildAppBar(){}

  Widget _buildBody(){
    return new TabBarView(
      controller: _controller,
      children: <Widget>[
        new FirstPage(), 
        new SecondPage(),
        new ThirdPage(),
      ]
    );
  }

  _buildBottomNavBar(){}

  @override
  Widget build(BuildContext context){
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("Tabs"),
        backgroundColor: Colors.deepOrange,
        bottom: new TabBar(
          controller: _controller,
          tabs: <Tab>[
            new Tab(icon: new Icon(Icons.arrow_forward)),
            new Tab(icon: new Icon(Icons.arrow_downward)),
            new Tab(icon: new Icon(Icons.arrow_back)),
          ]
        )
      ),
      body: _buildBody(),
      bottomNavigationBar: new Material(
        color: Colors.deepOrange,
        child: new TabBar(
          controller: _controller,
          tabs: <Tab>[
            new Tab(icon: new Icon(Icons.arrow_forward)),
            new Tab(icon: new Icon(Icons.arrow_downward)),
            new Tab(icon: new Icon(Icons.arrow_back)),
          ]
        ),
      )
    );
  }



}


















