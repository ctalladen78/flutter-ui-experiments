import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

// https://proandroiddev.com/you-might-not-need-redux-the-flutter-edition-9c11eba006d7
// https://medium.com/flutter-community/dart-what-are-mixins-3a72344011f3
class CounterModel extends Model {
  int _count = 0;
  int get count => _count;
}

abstract class Increment extends CounterModel {
  void increment() {
    _count++;
    notifyListeners();
  }
}

abstract class Decrement extends CounterModel {
  void decrement() {
    _count--;
    notifyListeners();
  }
}

abstract class Reset extends CounterModel {
  void decrement() {
    _count--;
    notifyListeners();
  }
}

// using mixins doesnt affect implementation of clients (widgets using the functions)
// but separation of concerns is improved
class AppModel extends Model with CounterModel, Increment, Decrement, Reset{}


class MyScopedModelWidget extends StatelessWidget {
  final AppModel appModelOne = new AppModel(); // stores different states
  final AppModel appModelTwo = new AppModel();

  @override
  Widget build(BuildContext context) {
    // return new ScopedModel<AppModel>(
      // model: new AppModel(),
      // child: new Scaffold(
        return new Scaffold(
      appBar: new AppBar(
        title: new Text('Scoped Model example'),
      ),
      body: new Center(
          child: new Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            new ScopedModel<AppModel>(
              model: appModelOne,
              child: new Counter(
                counterName: 'App Model One',
              ),
            ),
            new ScopedModel<AppModel>(
              model: appModelTwo,
              child: new Counter(
                counterName: 'App Model Two',
              ),
            ),
          ],
        ),
        ),
      // ),
    );
  }
}

class Counter extends StatelessWidget {
  final String counterName;
  Counter({Key key, this.counterName});

  @override
  Widget build(BuildContext context) {
    return new ScopedModelDescendant<AppModel>(
      builder: (context, child, model) => new Center(child: new Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          new Text("$counterName:"),
          new Text(model.count.toString()),
          new ButtonBar(
            // mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              new RawMaterialButton(
                child: new Icon(Icons.add),
                fillColor: Colors.greenAccent,
                onPressed: model.increment,
                shape: new CircleBorder(),
              ),
              new RawMaterialButton(
                child: new Icon(Icons.minimize),
                onPressed: model.decrement,
                fillColor: Colors.redAccent,
                shape: new CircleBorder(),
              ),
            ],
          ),
        ],
      ),),
    );
  }
}
















