import 'dart:async';
// import firebase_storage;
import 'dart:convert';
// import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
//https://pub.dartlang.org/packages/flutter_advanced_networkimage
import 'package:http/http.dart' as http;
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong/latlong.dart';


class ApiService {

  final String MAPBOX_TOKEN = "pk.eyJ1IjoiY3RhbGxhZGVuNzgiLCJhIjoiY2ppb2praTRyMGN1cDNwcW1ndnJrY2s3YiJ9.LZqZ2epLIiVuQaxH4-06FA";
  final String GOOGLE_PLACES_TOKEN = "";

  // https://pub.dartlang.org/packages/http
  Future<void> postData() async {
    var c = http.Client();
    var r = await c.post('https://randomuser.me/api/posts',
      body: {"test": "data"}
    );
    if(r.statusCode == 200) {
      print(r.body);
    }  
  }
  
  // https://randomuser.me/documentation#howto
  // https://flutter.io/cookbook/networking/background-parsing/
  Future<Widget> _getUserImageUri(http.Client client) async {
    var response = await client.get('https://randomuser.me/api/');
    if(response.statusCode == 200){ 
          print("Image Uri success");
      Map<String, dynamic> parsed = json.decode(response.body);
      var uri = parsed["results"][0]["picture"]["large"];
      return new CircleAvatar(
            radius: 32.0,
            backgroundColor: Colors.white,
            child: new CircleAvatar(
                radius: 30.0,
                backgroundImage: new NetworkImage(uri)
                ),
            );
    }
    print("Image Uri error");
    return Center(child: CircularProgressIndicator(),);
  }

  // https://blog.usejournal.com/flutter-async-beginner-friendly-guide-for-heavy-lifting-operations-cf8ec81833d7
  String parseUserImageUri(Map<String, dynamic> responseBody) {
    var uri = responseBody["results"][0]["picture"]["large"];
    // JsonEncoder encoder = new JsonEncoder.withIndent('  ');
    // String prettyprint = encoder.convert(parsed);
    // prettyprint["results"]
    return uri;
  }

  Widget getDefaultAvatar(){
    return CircleAvatar(
            radius: 30.0,
            backgroundColor: Colors.grey,
            child: Icon(Icons.person, size: 40.0)
          ); 
  }

  // TODO this returns null when no connection
  // TODO how to error handling futurebuilder
  // https://medium.com/flutterpub/network-call-with-progress-error-retry-in-flutter-8b58585f0b26
  Widget getUserImage() {
    return FutureBuilder(
      future: _getUserImageUri(http.Client()),
      initialData: getDefaultAvatar(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        print("SNAP ${snapshot.data}");
        if(snapshot.hasData && snapshot.connectionState == ConnectionState.done){
          return snapshot.data;
        }
        return snapshot.data;  // returns default avatar
      },
    );
  }
  
  /**
   * precondition : prefs.getString("isFirstInstall") == true
   */
  // get cities local from firebase storage
  void downloadCities() async {
    // TODO create assets localfile directory
  }

  // https://pub.dartlang.org/packages/google_maps_webservice#-readme-tab-
  Future<Place> getPlacesAutocomplete() async {
    // TODO get google places api token

  }

  /**
   * TODO save api keys, url template string in remote database
   */
  Widget buildStaticMap({ latitude : String, longitude :String, width : int, height : int}) {
    // budapest lat : 47.497913 long : 19.040236
    double lat = 47.497913;
    double long = 19.040236;
    if(latitude == null || longitude == null){latitude = lat; longitude = long;}
    String url = _buildMapBoxUrlString(lat: latitude.toString(), long: latitude.toString(), width: 600, height: 500);
    return new FlutterMap(
      options: new MapOptions(
        center: new LatLng(lat, long),
        zoom: 14.0,
        interactive: false,
      ),
      layers: [
        new TileLayerOptions(
          urlTemplate: url,
          // tileSize: 350,
          // additionalOptions: {
          //   'accessToken': '<PUT_ACCESS_TOKEN_HERE>',
          //   'id': 'mapbox.streets',
          // },
        ),
        // new MarkerLayerOptions(
        //   markers: [
        //     new Marker(
        //       width: 80.0,
        //       height: 80.0,
        //       point: new LatLng(lat, long),
        //       builder: (ctx) =>
        //       new Container(
        //         child: new FlutterLogo(),
        //       ),
        //     ),
        //   ],
        // ),
      ],
    );
  }

  // https://github.com/apptreesoftware/flutter_map/blob/master/example/lib/pages/map_controller.dart
  // https://www.mapbox.com/help/how-static-maps-work/
  // https://www.mapbox.com/api-documentation/?language=cURL
  String _buildMapBoxUrlString({lat : String, long : String, width: int, height: int}){
    // a+2196f3 : marker shows as letter "A" with color blue in hex
    String retVal = "https://api.mapbox.com/styles/v1/mapbox/streets-v10/static/pin-l-z+ed47ed(${long},${lat})/${long},${lat},14.25,0,50/${width}x${height}@2x?access_token=${MAPBOX_TOKEN}";
    return retVal;
  }

}

class Place {
  String name;
  String latitude;
  String longitude;
  Place({name : String, latitude : String, longitude : String});

}