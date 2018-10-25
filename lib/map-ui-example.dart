import "package:flutter/material.dart";
import "dart:async";
import "dart:convert";
import "package:flutter/services.dart";
import 'package:flutter_ui_experiments/user.dart';


class MapScreen extends StatefulWidget {
  MapScreen({Key key, this.title}) : super(key: key);

  final String title;

  @override
  MapScreenState createState() => new MapScreenState();
}

class MapScreenState extends State<MapScreen> {

  // bool _visible = true;
  // int _avatarCount;

  Future<String> _getUserFromFile() async {
    return await rootBundle.loadString("assets/jsonfile.json");
  }

  Future<List<User>> _getUser() async {
     var fileData = await _getUserFromFile();
     var jsonData = json.decode(fileData);
     List<User>  _list = new List<User>();
     void iterateMapEntry(key, value){
       User u = new User(value["name"], value["profile"], value["id"]);
       _list.add(u);
     }
     jsonData["userdata"].forEach(iterateMapEntry);
     return _list;
  } 
  /*
  Future<int> _getAvatarCount() async {
    var file = await _getUserFromFile();
    int d = json.decode(file)["userdata"];
    print(d);
    return d;
  }

  _getAvatarCount().then((i){
    _avatarCount = i;
  })
  */

  Widget _buildStaticMap(){
    // Image image = new Image(image: new AssetImage('assets/map-example.png'));
    return new Container(
      decoration: new BoxDecoration(
        image: new DecorationImage(
          image: new AssetImage('assets/map-example.png'),
          fit: BoxFit.cover
        ),
        /*
        borderRadius: new BorderRadius.all(new Radius.circular(50.0)),
        border: new Border.all(
          color: Colors.white,
          width: 5.0
        )
        */
      ),
    );
  }
  // align 20 pixels from appbar
  Widget _buildAvatarRow(){
    return new Container(
      margin: new EdgeInsets.symmetric(vertical: 10.0, horizontal: 5.0),
      height: 80.0,
      child: new FutureBuilder(
      future: _getUser(),
      builder: (BuildContext ctx, AsyncSnapshot snap){
        if(!snap.hasData){ return new Center(child: new CircularProgressIndicator());}
        return new ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: snap.data.length,
          itemBuilder: (BuildContext ctx, int idx) {
            String profile = snap.data[idx].profile;
            return new Container(
              // width: 100.0,
              // margin: new EdgeInsets.symmetric(vertical: 30.0, horizontal: 30.0),
              margin: new EdgeInsets.all(5.0),
              child: new CircleAvatar(
                radius: 32.0,
                backgroundColor: Colors.white,
                child: new CircleAvatar(
                  radius: 30.0,
                  backgroundImage: new NetworkImage(profile)),
                )
            );
          },
        );
      }
   ));
  }
  // align 20 pixels from bottom of screen
  Widget _buildImagesRow(){
    return new Container(
      height: 80.0,
      child: new FutureBuilder(
      future: _getUser(),
      builder: (BuildContext ctx, AsyncSnapshot snap){
        if(!snap.hasData){ return new Center(child: new CircularProgressIndicator());}
        return new ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: snap.data.length,
          itemBuilder: (BuildContext ctx, int idx) {
            String profile = snap.data[idx].profile;
            return new Container(
              // width: 100.0,
              margin: new EdgeInsets.all(10.0),
              child: new CircleAvatar(
                radius: 30.0,
                backgroundImage: new NetworkImage(profile)),
            );
          },
        );
      }
   ));
  }

  @override
  Widget build(BuildContext context) {
    // return new Center(child: new Container(child: new MaterialButton(
    //   onPressed: (){ print("button tapped");},
    // )));
    return new Scaffold(
      appBar:new AppBar(title: new Text("test")),
      body: new Stack(children: <Widget>[
        _buildStaticMap(),
        new Column(children: <Widget>[
          _buildAvatarRow(),
          // _buildImagesRow()
        ],)
      ],)
    );
  }
}