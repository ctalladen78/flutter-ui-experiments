import 'package:flutter/material.dart';

// https://github.com/AseemWangoo/flutter_programs/blob/master/TextField.dart
// void main() {
  // runApp(new MyApp());
// }

// class TextFieldDemo extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return new MaterialApp(home: new ButtonOptions());
//   }
// }

// class ButtonOptions extends StatefulWidget {
//   @override
//   State<StatefulWidget> createState() {
//     return new ButtonOptionsState();
//   }
// }

class TextFieldDemo extends StatefulWidget {
  _TextFieldDemoState createState() => _TextFieldDemoState();
}

// class _TextFieldDemoState extends State<TextFieldDemo> {
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//        child: child,
//     );
//   }
// }
class _TextFieldDemoState extends State<TextFieldDemo> {
  final _textFieldKey = GlobalKey<FormState>();
// class ButtonOptionsState extends State<ButtonOptions> {
  final TextEditingController _controller = new TextEditingController();
  String str = "";
  String submitStr = "";
  
  //not used
  // int votes = 0;
  // void countT() {
  //   setState(() {
  //     votes++;
  //   });
  // }

  void _changeText(String val) {
    setState(() {
      submitStr = val;
    });
    print("On RaisedButton : The text is $submitStr");
  }

  void _onSubmit(String val) {
    print("OnSubmit : The text is $val");
    setState(() {
      submitStr = val;
    });
  }

  @override
  void initState() { 
    super.initState();
    print("INIT TEXT FIELD");
  }

  @override
  void dispose() { 
    print("DISPOSED TEXT FIELD");
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    void _onChanged(String value) {
      print('"OnChange : " $value');
    }

    return new Scaffold(
      appBar: new AppBar(
        title: new Text('First Screen'),
      ),
      body: new Container(
        padding: const EdgeInsets.all(10.0),
        child: new Column(
          children: <Widget>[
            new TextField(
              autofocus: true,
              decoration: new InputDecoration(
                hintText: "Type something...",
              ),
              onChanged: (String value) {
                _onChanged(value);
              },
              controller: _controller,
              onSubmitted: (String submittedStr) {
                _onSubmit(submittedStr);
                _controller.text = "";
              },
            ),
            new Text('$submitStr'),
            new RaisedButton(
              child: new Text("Click me"),              
              onPressed: () {
                _changeText(_controller.text);
                // countT();
                // _controller.text = "";
                _controller.clear();
              },
            )
          ],
        ),
      ),
    );
  }
}