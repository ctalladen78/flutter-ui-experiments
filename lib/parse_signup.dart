import 'package:flutter/material.dart';
import 'package:flutter_ui_experiments/parse_service.dart';
// import 'package:parse_server_sdk/parse.dart';

class ParseSignUp extends StatefulWidget {
  @override
  _ParseSignUpState createState() => _ParseSignUpState();
}

class _ParseSignUpState extends State<ParseSignUp> {
  final GlobalKey<FormState> _formKey = new GlobalKey<FormState>();
  final TextEditingController _emailController = new TextEditingController();
  final TextEditingController _pwdController = new TextEditingController();
  final TextEditingController _userController = new TextEditingController();

  // final LoginService loginService = new LoginService();
  final ParseService parseService = new ParseService();
  // Parse globalParse;

  @override
  final data = {};

  Future<Null> submitForm(BuildContext context) async {
    String username = _userController.text;
    String email = _emailController.text;
    String password = _pwdController.text;

    //parseService.createUser(client: globalParse.client, username: "cy", email: email, password: password);
    ParseRequest().createUser(username: username, email: email, password: password);
    // if(user != null){
    //   user.sendEmailVerification();
    //   Navigator.pop(context);
    // }
  }

  @override
  void initState() {
    // TODO: implement initState
    
      super.initState();
    }

  //  use TextField.onChanged listener to implement clear text button
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: new Form(
            key: _formKey,
            child: new Column(
              children: <Widget>[
                SizedBox(height: 50.0,),
                Stack(
                  alignment: const Alignment(1.0, 1.0),
                  children: <Widget>[
                    TextFormField(
                      controller: _userController,
                      decoration: InputDecoration(
                        labelText: "Username",
                      ),
                      // onSaved: (field) => data.addAll({"fieldkey": field}),
                      keyboardType: TextInputType.text,
                      obscureText: true,
                    ),
                    IconButton(
                      icon: Icon(Icons.cancel),
                          onPressed: (){_emailController.clear();})
                  ]
                ),
                SizedBox(height: 50.0,),
                Stack(
                  alignment: const Alignment(1.0, 1.0),
                  children: <Widget>[
                  TextFormField(
                    controller: _pwdController,
                    decoration: InputDecoration(
                      labelText: "Password",
                    ),
                    // onSaved: (field) => data.addAll({"fieldkey": field}),
                    keyboardType: TextInputType.text,
                    obscureText: true,
                  ),
                  IconButton(
                      icon: Icon(Icons.cancel),
                        onPressed: (){_emailController.clear();})
                ],),
                SizedBox(height: 50.0,),
                Stack(
                  alignment: const Alignment(1.0, 1.0),
                  children: <Widget>[
                    TextFormField(
                      controller: _emailController,
                      decoration: InputDecoration(
                        labelText: "Email",
                      ),
                      // onSaved: (field) => data.addAll({"fieldkey": field}),
                      keyboardType: TextInputType.emailAddress,
                    ),
                    IconButton(
                      icon: Icon(Icons.cancel),
                          onPressed: (){_emailController.clear();})
                  ]
                ),
                SizedBox(height: 50.0,),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  
                  children: <Widget>[
                  FloatingActionButton(
                    backgroundColor: Colors.black,
                    child: Icon(Icons.cancel,
                      size: 56.0, 
                      color: Colors.grey,
                    ),
                    onPressed: (){Navigator.pop(context);},
                  ),
                  SizedBox(width: 30.0,),
                  RaisedButton(
                    onPressed: (){submitForm(context);},
                    child: Text("Sign in"),
                    padding: EdgeInsets.fromLTRB(30.0, 15.0, 30.0, 15.0),
                    color: Color(0xffdd4b39),
                  )
                ],)
                  // RaisedButton(
                  //   onPressed: (){submitForm(context);},
                  //   child: Text("Sign up"),
                  //   padding: EdgeInsets.fromLTRB(30.0, 15.0, 30.0, 15.0),
                  //   color: Color(0xffdd4b39),
                  // )
                ],)
            ),
          ),
        )
    );
  }
}

