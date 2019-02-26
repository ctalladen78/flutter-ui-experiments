import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert' as convert;
import 'dart:io';
import 'dart:core';
//https://pub.dartlang.org/packages/flutter_advanced_networkimage
import 'package:http/http.dart' as http;
import 'package:dio/dio.dart';

class ExpandingText extends StatefulWidget {
  ExpandingText(this.text);

  final String text;    
  bool isExpanded = false;

  @override
  _ExpandingTextState createState() => new _ExpandingTextState();

}

// https://trilixtech.com/2018/11/28/flutter-animations-part-1/
// https://medium.com/flutterpub/widgetoftheweek-animatedcontainer-widget-3ebae930ebba
// initial height of animated container is smaller than height after button is pressed
class _ExpandingTextState extends State<ExpandingText>
    with TickerProviderStateMixin<ExpandingText> {

  String CONTENTS = "initial data";

  
  Future<List<Trip>> getTripsList({userId: String}) async {
    var header = {
      "X-Parse-Application-Id":"yi5xfRZojERouKNKblwVqiTtEqUSSpdiJAAqBmYb",
      "X-Parse-REST-API-Key":"HHbC9ZNDAsl7uwJH4RvH4tEPkJOHkDCmfns6oFV7",
    };
    String PARSE_URI = "https://parseapi.back4app.com/";
    var options = Options(headers: header);
    // var data = {};
    String uri = PARSE_URI+"classes/Trip";
    var response = await Dio().get(uri,  options: options).catchError((onError){print("USER error $onError");});
    List<Trip> tripList = []; 
    if(response.statusCode == HttpStatus.ok){
      for(var u in response.data["results"]){
        var uo = Trip.fromJson(u);
        print("TRIP LIST $uo");
        tripList.add(uo);
      }
    }
    return tripList;
  }


  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: getTripsList(userId: "iHClyWQk1s"),
      // initialData: InitialData,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        return ListView.builder(
          itemCount: snapshot.data.length,
          itemBuilder: (context, index){
            return TripItem(trip: snapshot.data[index]);
          }
        );
      },
    );
    
  }
}

/**
  AnimatedContainer(
    duraton: Duration(millisecodns: 500),
    height: _height, // expand during setstate
    width: _width,
    oclor: Colors.gereen,
    child: Row(
      children: Widgets[
        Text(CONTENTS), // show rest of content
        GestureDetector(
          child: text("read more"),
          onTap: (){
            // load longer text
            setState((){
              CONTENTS = "longer versoin of text";
              
            });
          }
        )
      ]
    )
  )

  */
class TripItem extends StatefulWidget {
  final Trip trip;

  TripItem({Key key, this.trip}) : super(key: key);

  _TripItemState createState() => _TripItemState();
}

class _TripItemState extends State<TripItem> {
  var CONTENTS = "shorter version of text";
  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      // child: widget.trip,
      duration: Duration(milliseconds: 500),
      height: 300.0, // expand during setstate
      width: 200.0,
      color: Colors.green,
      child: Row(
        children: <Widget>[
          Text(CONTENTS), // show rest of content
          GestureDetector(
            child: Text("read more"),
            onTap: (){
              // load longer text
              setState((){
                CONTENTS = "longer version of text";
                  
              });
            }
          )
        ]
      )
    );
  }
}

class Trip{  
      String createdBy;
      String guide;
      List<String> inviteeList;
      String city;
      String description;
      String startDate;
      bool isReviewed;
      int duration;
      String paymentReference; 
    
      Trip({ 
        this.description,this.createdBy,this.guide,this.inviteeList,this.startDate,this.isReviewed,this.duration,this.paymentReference,this.city
      });
      
      // https://medium.com/flutter-community/parsing-complex-json-in-flutter-747c46655f51
      static Trip fromJson(Map<String,dynamic> json){

        var inviteesFromJson  = json['inviteeList'];
        List<String> invitees = inviteesFromJson.cast<String>();

        return Trip( 
            description: json['description'],
            createdBy: json['createdBy']["objectId"],
            city: json['city'],
            guide: json['guide'],
            inviteeList: invitees,
            startDate: json['startDate']["iso"],
            isReviewed: json['isReviewed'],
            duration: json['duration'],
            paymentReference: json['paymentReference'],
        );
      }
      
      Map<String, dynamic> toJson() => { 
            'description': description,
            'createdBy': createdBy,
            'city': city,
            'guide': guide,
            'inviteeList': inviteeList,
            'startDate': startDate,
            'isReviewed': isReviewed,
            'duration': duration,
            'paymentReference': paymentReference,
      };
    }