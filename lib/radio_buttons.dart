import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';


class RadioButtonScreen extends StatefulWidget {
  @override
  _MyAppState createState() => new _MyAppState();
}

class _MyAppState extends State<RadioButtonScreen> {
  int _radioValue1 = -1;
  int correctScore = 0;
  int _radioValue2 = -1;
  int _radioValue3 = -1;
  int _radioValue4 = -1;
  int _radioValue5 = -1;

  void _handleRadioValueChange1(int value) {
    setState(() {
      _radioValue1 = value;

      switch (_radioValue1) {
        case 0:
          Fluttertoast.showToast(msg: 'Correct !',toastLength: Toast.LENGTH_SHORT);
          correctScore++;
          break;
        case 1:
          Fluttertoast.showToast(msg: 'Try again !',toastLength: Toast.LENGTH_SHORT);
          break;
        case 2:
          Fluttertoast.showToast(msg: 'Try again !',toastLength: Toast.LENGTH_SHORT);
          break;
      }
    });
  }

  void _handleRadioValueChange2(int value) {
    setState(() {
      _radioValue2 = value;

      switch (_radioValue2) {
        case 0:
          Fluttertoast.showToast(msg: 'Try again !',toastLength: Toast.LENGTH_SHORT);
          break;
        case 1:
          Fluttertoast.showToast(msg: 'Correct !',toastLength: Toast.LENGTH_SHORT);
          correctScore++;
          break;
        case 2:
          Fluttertoast.showToast(msg: 'Try again !',toastLength: Toast.LENGTH_SHORT);
          break;
      }
    });
  }

  void _handleRadioValueChange3(int value) {
    setState(() {
      _radioValue3 = value;

      switch (_radioValue3) {
        case 0:
          Fluttertoast.showToast(msg: 'Try again !',toastLength: Toast.LENGTH_SHORT);
          break;
        case 1:
          Fluttertoast.showToast(msg: 'Correct !',toastLength: Toast.LENGTH_SHORT);
          correctScore++;
          break;
        case 2:
          Fluttertoast.showToast(msg: 'Try again !',toastLength: Toast.LENGTH_SHORT);
          break;
      }
    });
  }

  void _handleRadioValueChange4(int value) {
    setState(() {
      _radioValue4 = value;

      switch (_radioValue4) {
        case 0:
          Fluttertoast.showToast(msg: 'Correct !',toastLength: Toast.LENGTH_SHORT);
          correctScore++;
          break;
        case 1:
          Fluttertoast.showToast(msg: 'Try again !',toastLength: Toast.LENGTH_SHORT);
          break;
        case 2:
          Fluttertoast.showToast(msg: 'Try again !',toastLength: Toast.LENGTH_SHORT);
          break;
      }
    });
  }

  void _handleRadioValueChange5(int value) {
    setState(() {
      _radioValue5 = value;

      switch (_radioValue5) {
        case 0:
          Fluttertoast.showToast(msg: 'Try again !',toastLength: Toast.LENGTH_SHORT);
          break;
        case 1:
          Fluttertoast.showToast(msg: 'Try again !',toastLength: Toast.LENGTH_SHORT);
          break;
        case 2:
          Fluttertoast.showToast(msg: 'Correct !',toastLength: Toast.LENGTH_SHORT);
          correctScore++;
          break;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
        home: new Scaffold(
            appBar: AppBar(
              title: new Text('Kids Quiz App'),
              centerTitle: true,
              backgroundColor: Colors.blue,
            ),
            body: new Container(
                padding: EdgeInsets.all(8.0),
                child: new Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      new Text(
                        'Select correct answers from below:',
                        style: new TextStyle(
                            fontSize: 20.0, fontWeight: FontWeight.bold),
                      ),
                      new Padding(
                        padding: new EdgeInsets.all(8.0),
                      ),
                      new Divider(height: 5.0, color: Colors.black),
                      new Padding(
                        padding: new EdgeInsets.all(8.0),
                      ),
                      new Text(
                        'Lion is :',
                        style: new TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18.0,
                        ),
                      ),
                      new Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          new Radio(
                            value: 0,
                            groupValue: _radioValue1,
                            onChanged: _handleRadioValueChange1,
                          ),
                          new Text(
                            'Carnivore',
                            style: new TextStyle(fontSize: 16.0),
                          ),
                          new Radio(
                            value: 1,
                            groupValue: _radioValue1,
                            onChanged: _handleRadioValueChange1,
                          ),
                          new Text(
                            'Herbivore',
                            style: new TextStyle(
                              fontSize: 16.0,
                            ),
                          ),
                          new Radio(
                            value: 2,
                            groupValue: _radioValue1,
                            onChanged: _handleRadioValueChange1,
                          ),
                          new Text(
                            'Omnivore',
                            style: new TextStyle(fontSize: 16.0),
                          ),
                        ],
                      ),
                      new Divider(
                        height: 5.0,
                        color: Colors.black,
                      ),
                      new Padding(
                        padding: new EdgeInsets.all(8.0),
                      ),
                      new Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            new Text(
                              'Giraffe is :',
                              style: new TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18.0,
                              ),
                            ),
                            new Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                new Radio(
                                  value: 0,
                                  groupValue: _radioValue2,
                                  onChanged: _handleRadioValueChange2,
                                ),
                                new Text(
                                  'Carnivore',
                                  style: new TextStyle(fontSize: 16.0),
                                ),
                                new Radio(
                                  value: 1,
                                  groupValue: _radioValue2,
                                  onChanged: _handleRadioValueChange2,
                                ),
                                new Text(
                                  'Herbivore',
                                  style: new TextStyle(fontSize: 16.0),
                                ),
                                new Radio(
                                  value: 2,
                                  groupValue: _radioValue2,
                                  onChanged: _handleRadioValueChange2,
                                ),
                                new Text(
                                  'Omnivore',
                                  style: new TextStyle(fontSize: 16.0),
                                ),
                              ],
                            ),
                            new Divider(
                              height: 5.0,
                              color: Colors.black,
                            ),
                            new Padding(
                              padding: new EdgeInsets.all(8.0),
                            ),
                            new Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  new Text(
                                    'Elephant is :',
                                    style: new TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18.0,
                                    ),
                                  ),
                                  new Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      new Radio(
                                        value: 0,
                                        groupValue: _radioValue3,
                                        onChanged: _handleRadioValueChange3,
                                      ),
                                      new Text(
                                        'Carnivore',
                                        style: new TextStyle(fontSize: 16.0),
                                      ),
                                      new Radio(
                                        value: 1,
                                        groupValue: _radioValue3,
                                        onChanged: _handleRadioValueChange3,
                                      ),
                                      new Text(
                                        'Herbivore',
                                        style: new TextStyle(fontSize: 16.0),
                                      ),
                                      new Radio(
                                        value: 2,
                                        groupValue: _radioValue3,
                                        onChanged: _handleRadioValueChange3,
                                      ),
                                      new Text(
                                        'Omnivore',
                                        style: new TextStyle(fontSize: 16.0),
                                      ),
                                    ],
                                  ),
                                  new Divider(
                                    height: 5.0,
                                    color: Colors.black,
                                  ),
                                  new Padding(
                                    padding: new EdgeInsets.all(8.0),
                                  ),
                                  new Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      new Text(
                                        'Tiger is :',
                                        style: new TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18.0,
                                        ),
                                      ),
                                      new Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: <Widget>[
                                          new Radio(
                                            value: 0,
                                            groupValue: _radioValue4,
                                            onChanged: _handleRadioValueChange4,
                                          ),
                                          new Text(
                                            'Carnivore',
                                            style:
                                                new TextStyle(fontSize: 16.0),
                                          ),
                                          new Radio(
                                            value: 1,
                                            groupValue: _radioValue4,
                                            onChanged: _handleRadioValueChange4,
                                          ),
                                          new Text(
                                            'Herbivore',
                                            style:
                                                new TextStyle(fontSize: 16.0),
                                          ),
                                          new Radio(
                                            value: 2,
                                            groupValue: _radioValue4,
                                            onChanged: _handleRadioValueChange4,
                                          ),
                                          new Text(
                                            'Omnivore',
                                            style:
                                                new TextStyle(fontSize: 16.0),
                                          ),
                                        ],
                                      ),
                                      new Divider(
                                        height: 5.0,
                                        color: Colors.black,
                                      ),
                                      new Padding(
                                        padding: new EdgeInsets.all(8.0),
                                      ),
                                      new Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: <Widget>[
                                          new Text(
                                            'Bear is :',
                                            style: new TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 18.0,
                                            ),
                                          ),
                                          new Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: <Widget>[
                                              new Radio(
                                                value: 0,
                                                groupValue: _radioValue5,
                                                onChanged:
                                                    _handleRadioValueChange5,
                                              ),
                                              new Text(
                                                'Carnivore',
                                                style: new TextStyle(
                                                    fontSize: 16.0),
                                              ),
                                              new Radio(
                                                value: 1,
                                                groupValue: _radioValue5,
                                                onChanged:
                                                    _handleRadioValueChange5,
                                              ),
                                              new Text(
                                                'Herbivore',
                                                style: new TextStyle(
                                                    fontSize: 16.0),
                                              ),
                                              new Radio(
                                                value: 2,
                                                groupValue: _radioValue5,
                                                onChanged:
                                                    _handleRadioValueChange5,
                                              ),
                                              new Text(
                                                'Omnivore',
                                                style: new TextStyle(
                                                    fontSize: 16.0),
                                              ),
                                            ],
                                          ),
                                          new Divider(
                                            height: 5.0,
                                            color: Colors.black,
                                          ),
                                          new Padding(
                                            padding: new EdgeInsets.all(8.0),
                                          ),
                                          new RaisedButton(
                                            onPressed: validateAnswers,
                                            child: new Text(
                                              'Check Final Score',

                                              style: new TextStyle(
                                                  fontSize: 16.0,
                                                  fontWeight: FontWeight.normal,
                                                  color: Colors.white),
                                            ),
                                            color: Theme.of(context).accentColor,
                                            shape: new RoundedRectangleBorder(
                                                borderRadius:
                                                    new BorderRadius.circular(
                                                        20.0)),
                                          ),
                                          new Padding(
                                            padding: EdgeInsets.all(4.0),
                                          ),
                                          new RaisedButton(
                                            onPressed: resetSelection,
                                            child: new Text(
                                              'Reset Selection',
                                              style: new TextStyle(
                                                  fontWeight: FontWeight.normal,
                                                  fontSize: 16.0,
                                                  color: Colors.white),
                                            ),
                                            color: Theme.of(context).accentColor,
                                            shape: new RoundedRectangleBorder(
                                                borderRadius:
                                                    new BorderRadius.circular(
                                                        20.0)),
                                          )
                                        ],
                                      ),
                                    ],
                                  )
                                ])
                          ])
                    ]))));
  }

  void resetSelection() {
    _handleRadioValueChange1(-1);
    _handleRadioValueChange2(-1);
    _handleRadioValueChange3(-1);
    _handleRadioValueChange4(-1);
    _handleRadioValueChange5(-1);
    correctScore = 0;
  }

  void validateAnswers() {
    if (_radioValue1 == -1 && _radioValue2 == -1 &&
        _radioValue3 == -1 && _radioValue4 == -1 &&
        _radioValue5 == -1) {
      Fluttertoast.showToast(msg: 'Please select atleast one answer',
          toastLength: Toast.LENGTH_SHORT);
    } else {
      Fluttertoast.showToast(
          msg: 'Your total score is: $correctScore out of 5',
          toastLength: Toast.LENGTH_LONG);
    }
  }
}