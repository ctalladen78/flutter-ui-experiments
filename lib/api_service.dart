import 'dart:async';
// import firebase_storage;
import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
//https://pub.dartlang.org/packages/flutter_advanced_networkimage
import 'package:http/http.dart' as http;

class ApiService {

  // https://randomuser.me/documentation#howto
  // https://flutter.io/cookbook/networking/background-parsing/
  Future<String> _getUserImageUri(http.Client client) async {
    var response = await client.get('https://randomuser.me/api/');
    if(response.statusCode == 200){ 
      Map<String, dynamic> parsed = json.decode(response.body);
      var uri = parsed["results"][0]["picture"]["large"];
      // print("PARSED $uri");
      return uri;
      // return compute(parseUserImageUri, parsed);
    }
    return "example";
  }

  // https://blog.usejournal.com/flutter-async-beginner-friendly-guide-for-heavy-lifting-operations-cf8ec81833d7
  String parseUserImageUri(Map<String, dynamic> responseBody) {
    var uri = responseBody["results"][0]["picture"]["large"];
    // JsonEncoder encoder = new JsonEncoder.withIndent('  ');
    // String prettyprint = encoder.convert(parsed);
    // print("PARSED $uri");
    return uri;
    // prettyprint["results"]
  }

  Widget getUserImage() {
    return FutureBuilder(
      future: _getUserImageUri(http.Client()),
      // initialData: InitialData,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        print("SNAP ${snapshot.data}");
        if(snapshot.hasData){
          return new CircleAvatar(
                      radius: 32.0,
                      backgroundColor: Colors.white,
                      child: new CircleAvatar(
                        radius: 30.0,
                        backgroundImage: new NetworkImage(snapshot.data)
                        ),
                      );
        }
        return new Center(child: new CircularProgressIndicator());     
      },
    );
  }

  // new CircleAvatar(
  //                     radius: 32.0,
  //                     backgroundColor: Colors.white,
  //                     child: new CircleAvatar(
  //                       radius: 30.0,
  //                       // backgroundImage: new Image.network('https://picsum.photos/1400/901/?random'),
  //                       backgroundImage: new NetworkImage('https://picsum.photos/1400/901/?random')
  //                       ),
  //                     ),
}