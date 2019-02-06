import 'package:flutter/material.dart';

// TODO firebase animated list 
class InvitationScreen extends StatefulWidget {
  _InvitationScreenState createState() => _InvitationScreenState();
}

class _InvitationScreenState extends State<InvitationScreen> {

  Widget _buildInvitationList(){
    return AnimatedList(
      itemBuilder: (BuildContext context, _ , Animation animation){

      },
    );
  }

  Widget _buildScaffold() {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      appBar: AppBar(
        backgroundColor: Colors.orangeAccent[300],
        leading: Text("data"),
      ),
    );
  }
  
  @override
  Widget build(BuildContext context) {
    return _buildScaffold();
  }
}