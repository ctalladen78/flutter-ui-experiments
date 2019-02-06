import 'dart:async';
import 'dart:convert' as convert;
import 'dart:io';
import 'package:flutter/material.dart';
//https://pub.dartlang.org/packages/flutter_advanced_networkimage
import 'package:http/http.dart' as http;

class ParseService {
  // parse config 
  // app id (minimum required): c4783d1ad85c404f28e38df4da6d2fabd0a9371c
  // server url : ec2-52-90-30-167.compute-1.amazonaws.com/parse/classes/_User
  // rest api key (master key)  : 3d4fa4aba913f09dae22f15cf27a198e26e325c9
  // file key : 88e4f7776f786e0d00c4f3f5001a1b6c6bafd618
}

// websocket client
// var socket = await WebSocket.connect('ws://127.0.0.1:4040/ws');
// socket.add('Hello, World!');

// https://pub.dartlang.org/documentation/http/latest/
// https://pub.dartlang.org/documentation/http/latest/http/Request-class.html
// https://pub.dartlang.org/packages/http
// using parse server rest api
// implement services for CRUD
// profile
// trip
// chatroom
// offers (in app messages using parse push notification)
// http interface
// TODO create parse request object that contains  header
// https://v1-dartlang-org.firebaseapp.com/dart-vm/dart-by-example#making-a-post-request
class ParseRequest {
  String userAgent;
  var client = http.Client();

  Map<String, String> remoteHeader = {
      "X-Parse-Application-Id":"c4783d1ad85c404f28e38df4da6d2fabd0a9371c",
      "X-Parse-REST-API-Key":"3d4fa4aba913f09dae22f15cf27a198e26e325c9"
      };
  
  String remoteParseUri = "http://ec2-52-90-30-167.compute-1.amazonaws.com/parse/classes/_User";

  ParseRequest();

  Future<String> testRemoteServer() async {
    //  request.headers['user-agent'] = userAgent;
    var response = await client.get(
      remoteParseUri,
      headers: remoteHeader
    );
    print(response.headers);
    print(response.body);

    // client.close();
    if (response.statusCode == 200){
      print("RESPONSE OK");
      var jsonResponse = convert.jsonDecode(response.body); //https://www.dartlang.org/guides/libraries/library-tour#dartconvert---decoding-and-encoding-json-utf-8-and-more
      print(jsonResponse);
    }
  } 

  // TODO reset password
  // send password to phone
  Future<bool> resetPassword() {

  }

  // TODO verify using phone number
  // facebook accountkit 
  // 
  Future<bool> phoneValidate() {

  }


  // TODO send email validation on signup
  // TODO setup sendgrid on bitnami
  // https://www.npmjs.com/package/parse-server-sendgrid-adapter
  Future<bool> emailValidate() async {

    return false;
  }

  // TODO login with facebook
  Future<bool> loginFacebook() async {

    return false;
  }

  // TODO signup and link user to facebook
  // https://docs.parseplatform.org/rest/guide/#signing-up-and-logging-in
  // https://www.back4app.com/docs/android/android-app-facebook-login-tutorial
  Future<bool> signupFacebook() async {
    
    return false;
  }


  // https://docs.parseplatform.org/rest/guide/#users-api
  Future<bool> createUser({username: String, password: String, email: String}) async {
    //TODO create request object
    //  request.headers['user-agent'] = userAgent;
    var response = await client.post(
      "http://ec2-52-90-30-167.compute-1.amazonaws.com/parse/classes/_User",
      headers: remoteHeader,
      body: {"email": email, "username": username, "password": password}
    );
    print(response.headers);
    print(response.body);

    // client.close();
    if (response.statusCode == 200){
      print("RESPONSE OK");
      var jsonResponse = convert.jsonDecode(response.body); //https://www.dartlang.org/guides/libraries/library-tour#dartconvert---decoding-and-encoding-json-utf-8-and-more
      var itemCount = jsonResponse['totalItems'];
      print(jsonResponse);
      return true;
    }
    return false;
    
  }

  Future<Map<String, dynamic>> sendLocalRequest() async {
    //TODO create request object
    //  request.headers['user-agent'] = userAgent;
    var response = await client.get(
      remoteParseUri,
      headers: remoteHeader
    );
  }

}






