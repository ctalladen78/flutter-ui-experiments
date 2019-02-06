import 'package:flutter/material.dart';
import 'api_service.dart';
import 'package:fluttertoast/fluttertoast.dart';

class SliverSamplePage extends StatefulWidget {
  SliverSamplePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _SliverSamplePageState createState() => new _SliverSamplePageState();
}

// https://medium.com/@diegoveloper/flutter-collapsing-toolbar-sliver-app-bar-14b858e87abe
class _SliverSamplePageState extends State<SliverSamplePage> {
  ApiService apiService = new ApiService();

  Widget _buildButtonRow() {
    return Container(
      // height: 20.0, 
      // padding: EdgeInsets.all(10.0),
      child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        _buildConnectButton(),
        SizedBox(width: 10.0),
        _buildMessageButton(),
      ],),
    );
  }

  Widget _buildConnectButton() {
    return InputChip(
      backgroundColor: Colors.greenAccent[200],
      avatar: CircleAvatar(
        radius: 50.0, 
        backgroundColor: Colors.white70,
        child: new Icon(Icons.add, size: 20.0, color: Colors.black87)
      ),
      label: new Text("Connect"),
      onPressed: (){
        Fluttertoast.showToast(msg: 'Added to connections',toastLength: Toast.LENGTH_SHORT);
      },
    );
  }
  Widget _buildMessageButton() {
      return InputChip(
        backgroundColor: Colors.orangeAccent[200],
        avatar: CircleAvatar(
                radius: 50.0, 
                backgroundColor: Colors.white70,
                child: new Icon(Icons.send, size: 15.0, color: Colors.black87,)
              ),            // avatar: new Icon(Icons.send, size: 20.0,),
        label: new Text("Message"),
        labelStyle: TextStyle(fontSize: 12.0, color: Colors.black87),
        // padding: EdgeInsets.all(10.0),
        onPressed: (){
              // TODO Navigate to chat screen with the user model sent as argument
        },
      );  
  }

  Widget _getBackgroundCover() {
    Widget cover = new Image.network(
                  'https://picsum.photos/1400/935/?random', // TODO how to handle error no connection
                  fit: BoxFit.cover);
    if(cover == null){ 
      print("NULL cover");
      return Image(color: Colors.greenAccent[300],);
    }
    print("cover not null");
    return cover;
  }

  Widget _buildMapSection() {
    // map section
    return Padding(
      padding: EdgeInsets.all(10.0),
      child: Container(
        height: 200,
        width: MediaQuery.of(context).size.width,
        child: apiService.buildStaticMap(latitude: "testLat", longitude: "testLong", width: 300, height: 200),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: new Text(widget.title),
      ),
      // leading: new CircleAvatar(backgroundImage: new NetworkImage(profile)),
      body: new CustomScrollView(
        slivers: <Widget>[
          new SliverAppBar(
            pinned: true,
            floating: false, 
            expandedHeight: 450.0,
            flexibleSpace: new FlexibleSpaceBar(
              background: new Stack( children: <Widget>[
                _getBackgroundCover(),
                  new Center(child: new Column(children: <Widget>[
                    new SizedBox(height: 30.0,),
                    apiService.getUserImage(),
                    // ApiService().getUserImage(),
                    new SizedBox(height: 20.0,),
                    new Text("First Lastname", style: TextStyle(
                      color: Colors.white,
                      fontSize: 20.0
                    ),),
                    _buildMapSection()
                ]),
                )
              ]),
              // title: const Text('Demo'),
              title: _buildButtonRow()
            ),
          ),
          new SliverGrid(
            gridDelegate: new SliverGridDelegateWithMaxCrossAxisExtent(
              maxCrossAxisExtent: 200.0,
              mainAxisSpacing: 10.0,
              crossAxisSpacing: 10.0,
              childAspectRatio: 4.0,
            ),
            delegate: new SliverChildBuilderDelegate(
              (BuildContext context, int index) {
                return new Container(
                  alignment: Alignment.center,
                  color: Colors.teal[100 * (index % 9)],
                  child: new Text('grid item $index'),
                );
              },
              childCount: 20,
            ),
          ),
          new SliverFixedExtentList(
            itemExtent: 50.0,
            delegate: new SliverChildBuilderDelegate(
              (BuildContext context, int index) {
                return new Container(
                  alignment: Alignment.center,
                  color: Colors.lightBlue[100 * (index % 9)],
                  child: new Text('list item $index'),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}