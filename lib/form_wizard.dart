import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// TODO create wizard form similar to airbnb
// https://github.com/matthew-carroll/flutter_example_form_focus.git
class VerticalForm extends StatefulWidget {
  @override
  _VerticalFormState createState() => new _VerticalFormState();
}

class _VerticalFormState extends State<VerticalForm> {

  FocusNode focusNode1;
  FocusNode focusNode2;
  FocusNode focusNode3;
  FocusNode focusNode4;
  FocusNode focusNode5;
  FocusNode focusNode6;
  TextEditingController controller1 = new TextEditingController();
  TextEditingController controller2 = new TextEditingController();
  TextEditingController controller3 = new TextEditingController();
  GlobalKey<FormState> formKey1 = new GlobalKey<FormState>();
  // https://www.didierboelens.com/2018/06/widget---state---context---inheritedwidget/
  LocalKey clearBtn1;

  var data = {};
  int currentNode = 1; // TODO use modulus operator (currentNode % list.length)
  List<FocusNode> nodeList;

  @override
  void initState() {
    super.initState();
    print("INIT FORM WIZARD");
    focusNode1 = new FocusNode();  // TODO focusnodes are good for programmatically moving from one field to another
    focusNode2 = new FocusNode();
    focusNode3 = new FocusNode();
    focusNode4 = new FocusNode();
    focusNode5 = new FocusNode();
    focusNode6 = new FocusNode();

    controller1.addListener(_ctrlOneListener);
    nodeList = [focusNode1, focusNode2, focusNode3, focusNode4, focusNode5, focusNode6];
  }

  void _ctrlOneListener(){
    String val = controller1.text;
    print("controller one value ${val}");
  }

  @override
  void dispose() {
    print("DISPOSED FORM WIZARD");
    currentNode = 0;
    focusNode1.dispose();
    focusNode2.dispose();
    focusNode3.dispose();
    focusNode4.dispose();
    focusNode5.dispose();
    super.dispose();
  }

  Widget _buildTextFormField({
    InputDecoration decoration,
    Key key,
    String hintText,
    TextInputAction keyboardAction = TextInputAction.done,
    Function(String) onSubmitted,
    FocusNode focusNode,
    TextEditingController ctrl,
    Function onChangedFunc
  }) {
    return new FormField(
      builder: (FormFieldState fieldState) {
        return new TextField(
          // onChanged: onChangedFunc,
          key: key,
          controller: ctrl,
          decoration: new InputDecoration(
            hintText: hintText,
          ),
          textInputAction: keyboardAction,
          onSubmitted: onSubmitted,
          focusNode: focusNode,
          // TODO onSaved exists only for textformfield, so formstate.save doesnt apply
          // TODO onSubmitted and onChanged only exists for textfield, this is good for one off text fields 
          // TODO ie chat submit
        );
      },
    );
  }

  Widget toggleNext(){

  }

  void toNext(){
    setState(() {
                    currentNode = currentNode % nodeList.length;
                    FocusScope.of(context).requestFocus(nodeList[currentNode]);
                    currentNode++;
                  });
  }

  @override
  Widget build(BuildContext context) {
    // focusNode1.addListener(listener)
    print("CURRENT NODE ${currentNode}");
    return new Scaffold(
      appBar: AppBar(title: Text("Form Wizard"),),
      body: SingleChildScrollView(
      child: new Padding(
        padding: const EdgeInsets.all(16.0),
        child: new Form(
          key: formKey1,
          child: new Column(
            children: <Widget>[
              SizedBox(height: 100.0,),
              Text("Tell me about yourself, Mr. Anderson"),
              SizedBox(height: 50.0,),
              Row(children: <Widget>[
                Expanded(
                  child: _buildTextFormField(
                    onChangedFunc: (){
                      // clearBtn1.
                    },
                    // ctrl: controller1,
                    // decoration: InputDecoration(labelText: "Go to next"),
                    hintText: 'Controller 1',
                    keyboardAction: TextInputAction.next,
                    // keyboardAction: TextInputAction.none,
                    focusNode: focusNode1,
                    onSubmitted: (String value) {
                      data.addAll({"controllerOneValue":value});
                      FocusScope.of(context).requestFocus(focusNode2);
                    },
                  ),
                ),
                IconButton(
                  key: clearBtn1,
                  icon: Icon(Icons.arrow_forward), onPressed: (){toNext();}),
              ],),
              SizedBox(height: 100.0,),
              Text("Do you wish to take the red pill, or the blue pill?"),
              SizedBox(height: 50.0,),
              Row(children: <Widget>[
                Expanded(
                  child: _buildTextFormField(
                  // ctrl: controller2,
                  hintText: 'Controller 2',
                  keyboardAction: TextInputAction.next,
                  // keyboardAction: TextInputAction.unspecified,
                  focusNode: focusNode2,
                  onSubmitted: (String value) {
                    FocusScope.of(context).requestFocus(focusNode3);
                  },
                ),
                ),
                IconButton(icon: Icon(Icons.arrow_forward), onPressed: (){toNext();}),
               ]
              ),
              
              SizedBox(height: 100.0,),
              Text("Do you wish to take the red pill, or the blue pill?"),
              SizedBox(height: 50.0,),
              Row(children: <Widget>[
                Expanded(
                  child: _buildTextFormField(
                    hintText: 'Done',
                    keyboardAction: TextInputAction.done,
                    focusNode: focusNode3,
                    onSubmitted: (String value) {
                      print('Handling first name submission');
                      FocusScope.of(context).requestFocus(focusNode4);
                    },
                  ),
                ),
                IconButton(icon: Icon(Icons.arrow_forward), onPressed: (){toNext();}),
              ]
              ),
                            SizedBox(height: 50.0,),
              
              TextFormField(
                keyboardType: TextInputType.multiline,
                focusNode: focusNode4,
                decoration: InputDecoration(icon: Icon(Icons.ac_unit), hintText: "First Name"),
                controller: controller1,
                onSaved: (formData){
                  print("field ${formData}");
                },
              ),
                            SizedBox(height: 50.0,),

              Row(
                mainAxisAlignment:MainAxisAlignment.start,
                children: <Widget>[
                  Expanded(
                    child: TextFormField(
                  keyboardType: TextInputType.multiline,
                  focusNode: focusNode5,
                  decoration: InputDecoration(icon: Icon(Icons.ac_unit), hintText: "Last Name"),
                  // keyboardType: TextInputType.text,
                  controller: controller2,  // required but not really needed for data
                  onSaved: (fieldData){
                    String c1 = controller1.text; 
                    String c2 = controller2.text;
                    print('TEXT FIELD 1 SAVED ${c1} ${c2}');
                    data.addAll({"controllerOneValue": c1});
                    data.addAll({"controllerTwoValue": c2});
                    data.addAll({"controllerThreeValue": fieldData});
                    print("TOTAL DATA ${data}");
                    print("FIELD DATA ${fieldData}"); // TODO this will fire when formState.save() is called
                  },
                    ),
                  ),     
                  IconButton(icon: Icon(Icons.arrow_forward), onPressed: (){toNext();}),

              ],),
              /*
              MaterialButton(
                color: Colors.blueAccent[300],
                child: new Text("SUBMIT"),
                onPressed: (){
                  final FormState form1State = formKey1.currentState;
                  form1State.save();
                  // TODO unnecessary to access controller value here if we have a textformfield,
                  // TODO better to use textformfield.onSaved() method to aggregate all form field values into a wrapper object
                  // TODO here we are using a simple map primitive
                  // onSavedAllFields(data);
                  controller1.clear();
                  controller2.clear();
                  // print('TEXT FIELD 1 SAVED ${c1} ${c2}');
                },
              ),
              */
              SizedBox(height: 50.0,),

            ],
          ),
        ),
      ),
    ),
      persistentFooterButtons: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            MaterialButton(
              color: Theme.of(context).buttonColor,
              padding: EdgeInsets.only(left: 50.0, right: 50.0),
              child: Text("Submit"),
              onPressed: (){
                final FormState form1State = formKey1.currentState;
                form1State.validate();
                  form1State.save();
                  controller1.clear();
                  controller2.clear();
              },),
            SizedBox(width: 100.0,)
          ],
        ),
        // new IconButton(icon: new Icon(Icons.timer), onPressed: () => {}),
        // new IconButton(icon: new Icon(Icons.people), onPressed: () => {}),
        // new IconButton(icon: new Icon(Icons.map), onPressed: () => {}),
      ],
    );
  }
}

class NextButton extends StatefulWidget {
    Function closure;

  NextButton({Key key , Function func}) : super(key: key);

  _NextButtonState createState() => _NextButtonState();
}

class _NextButtonState extends State<NextButton> {
  Function closure;
  // _NextButtonState(Function f){closure = f};
  bool isVisible;
  @override
  void initState() {
      isVisible = false;
      super.initState();
    }
  @override
  Widget build(BuildContext context) {
    return (isVisible) ? Container() : Container();
  }
}