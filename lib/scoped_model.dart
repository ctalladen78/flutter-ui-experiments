import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

class AppModel extends Model {
  int _count = 0;
  int get count => _count;

  void increment() {
    _count++;
    notifyListeners();
  }

  void decrement() {
    _count--;
    notifyListeners();
  }
}


class MyScopedModelWidget extends StatelessWidget {
  final AppModel appModelOne = new AppModel();
  final AppModel appModelTwo = new AppModel();

  @override
  Widget build(BuildContext context) {
    return new ScopedModel<AppModel>(
      model: new AppModel(),
      child: new Scaffold(
      appBar: new AppBar(
        title: new Text('Scoped Model example'),
      ),
      body: new Center(
        child: new Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
    ),
    );
  }
}

class Counter extends StatelessWidget {
  final String counterName;
  Counter({Key key, this.counterName});

  @override
  Widget build(BuildContext context) {
    return new ScopedModelDescendant<AppModel>(
      builder: (context, child, model) => new Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          new Text("$counterName:"),
          new Text(model.count.toString()),
          new ButtonBar(
            children: <Widget>[
              new IconButton(
                icon: new Icon(Icons.add),
                onPressed: model.increment,
              ),
              new IconButton(
                icon: new Icon(Icons.minimize),
                onPressed: model.decrement,
              ),
            ],
          ),
        ],
      )
    );
  }
}
















