import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;
import 'package:flutter_ui_experiments/user.dart';

class JsonPage extends StatefulWidget {
  JsonPage({Key key, this.info}) : super(key: key);

  final Map<String, int> info;

  @override
  JsonPageState createState() => new JsonPageState();
}
// https://medium.com/@jimmyhott/using-futurebuilder-to-create-a-better-widget-4c7d4f52a329
class JsonPageState extends State<JsonPage> {

  Future<String> _getUserFromFile() async {
    return await rootBundle.loadString("assets/jsonfile.json");
  }

  Future<List<User>> _getUser() async {
    // load json data into memory
    var fileData = await _getUserFromFile(); 
    // var fileData = await rootBundle.loadString("assets/jsonfile.json");
    var jsonData = json.decode(fileData);
    print(jsonData["userdata"]);
    // map to list
    List<User> list = new List<User>();

    Map<String, int> map = {
        'one': 1,
        'two': 2,
        'twelve': 12};

    void iterateMapEntry(key, value) {
      // map[key] = value;
      // print(value["name"]);
      // print(value["profile"]);
      // print(value["id"]);
      // print('$key:$value');//string interpolation in action
      User u = new User(value["name"], value["profile"], value["id"]);
      list.add(u);
    }
    jsonData["userdata"].forEach(iterateMapEntry);
    print("DATA 1 $list");
    return list;
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: new Container(child: new FutureBuilder(
        future: _getUser(),
        builder: (BuildContext ctx, AsyncSnapshot snap){
          if(!snap.hasData){
            print("SNAP 0");
            return new Center(child: new Container(child: new CircularProgressIndicator(),)); 
          }
          return new ListView.builder(
            itemCount:snap.data.length,
            itemBuilder: (BuildContext ictx, int idx){
              String name = snap.data[idx].name;
              String profile = snap.data[idx].profile;
              return new ListTile(
                leading: new CircleAvatar(backgroundImage: new NetworkImage(profile)),
                title: new Text(name),
                subtitle: new Text(profile)
              );
            }
          );
        },
      ),
      ),
    );
  }
}

