import 'dart:io';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:objectdb/objectdb.dart';

// https://github.com/netz-chat/flutter_examples/blob/master/objectdb/listview/lib/main.dart
// declare db object
ObjectDB db;

void main() async {
  // get document directory using path_provider plugin
  Directory appDocDir = await getApplicationDocumentsDirectory();

  String dbFilePath = [appDocDir.path, 'user.db'].join('/');

  // delete old database file if exists
  File dbFile = File(dbFilePath);

  // check if database already exists
  var isNew = !await dbFile.exists();

  // initialize and open database
  db = ObjectDB(dbFilePath);
  db.open();

  // insert sample data
  if (isNew) {
    db.insertMany([
      {
        'name': {'first': 'Alex', 'last': 'Boyle'},
        'message': 'abc',
        'active': true
      },
      {
        'name': {'first': 'Maia', 'last': 'Herzog'},
        'message': 'def',
        'active': true
      },
      {
        'name': {'first': 'Curtis', 'last': 'Smith'},
        'message': 'ghi',
        'active': true
      },
      {
        'name': {'first': 'Jaquelin', 'last': 'Renner'},
        'message': 'jkl',
        'active': false
      },
      {
        'name': {'first': 'Denis', 'last': 'Swift'},
        'message': 'mno',
        'active': true
      },
      {
        'name': {'first': 'Anna', 'last': 'Metz'},
        'message': 'pqr',
        'active': true
      },
      {
        'name': {'first': 'Malinda', 'last': 'Reynolds'},
        'message': 'stu',
        'active': false
      },
    ]);
  }

  runApp(new MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'ObjectDB Demo',
      theme: new ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: new MyHomePage(title: 'ObjectDB Demo Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => new _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List _contacts;

  // load contacts from database where active == true
  void loadContactsFromDb() async {
    List contacts = await db.find({'active': true});
    setState(() {
      _contacts = contacts;
    });
  }

  @override
  void initState() {
    this.loadContactsFromDb();
    super.initState();
  }

  @override
  void dispose() async {
    await db.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text(widget.title),
      ),
      body: this._contacts == null // check if _contacts has been initialized
          ? Center(
              child: Text('loading...'),
            )
          : ListView(
              children: this
                  ._contacts
                  .map((contact) => contactItem(contact))
                  .toList(),
            ),
    );
  }
}

// creates list tile with contact info
Widget contactItem(Map contact) {
  return ListTile(
    title: Text(contact['name']['first'] + ' ' + contact['name']['last']),
    subtitle: Text(contact['message']),
  );
}