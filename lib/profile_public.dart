import 'package:flutter/material.dart';
import 'api_service.dart';

class ProfileTabScreen extends StatefulWidget {
  _ProfileTabScreenState createState() => _ProfileTabScreenState();
}

class _ProfileTabScreenState extends State<ProfileTabScreen> with SingleTickerProviderStateMixin{
  
  ApiService apiService = new ApiService();
  ScrollController scrollController = new ScrollController();

  @override
  void initState() {
    super.initState();
    // _tabController = new TabController(vsync: this, length: 2);
  }
  

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[ 
          _buildProfileHeader(context),
          // TODO implement button row
          /**
           
           * currentIndex: _selectedIndex,
          onTap: (int index) {
            setState(() {
              _selectedIndex = index;
              controller.animateToPage(
                _selectedIndex,
                duration: kTabScrollDuration,
                // curve: scrollCurve,
                curve: Curves.fastOutSlowIn
              );
            });
          },
           */
          /**
           * controller.animateToPage(
                _selectedIndex,
                duration: kTabScrollDuration,
                // curve: scrollCurve,
                curve: Curves.fastOutSlowIn
              );
           */
          ButtonBar(
            alignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              IconButton(icon: Icon(Icons.security),
                color: Colors.blueAccent[300],
                onPressed: (){
                  // _selectedIndex = index;
                  scrollController.animateTo(1.0,
                    duration: kTabScrollDuration,
                    curve: Curves.fastOutSlowIn
                  );
                },
              ),
              SizedBox(width: 5.0,),
              IconButton(icon: Icon(Icons.security),
                color: Colors.yellowAccent[300],
                onPressed: (){
                  // _selectedIndex = index;
                  scrollController.animateTo(0.0,
                    duration: kTabScrollDuration,
                    curve: Curves.fastOutSlowIn
                  );
                },
              )

            ],
          ),
          new Container(height: 200.0, child: new ListView.builder(
          // ListView.builder(
            scrollDirection: Axis.horizontal,
            controller: scrollController,
            itemCount: 2,
            itemBuilder: (BuildContext ictx, int idx){
              // String name = snap.data[idx].name;
              // String profile = snap.data[idx].profile;
              if(idx == 0){
                // return first page
                return new Container(
                  width: MediaQuery.of(ictx).size.width,
                  margin: new EdgeInsets.all(5.0),
                  child: Text("test 1")
                );              }
              if(idx == 1){
                // return second page
                return new Container(
                  width: MediaQuery.of(ictx).size.width,
                  margin: new EdgeInsets.all(5.0),
                  child: Text("test 2 ")
                );   
              }
              
            }
          )
          ),
          
          
        ],
      ),
    );
    
  }
}

Widget _buildProfileHeader(BuildContext ctx){
    return  Container(
          // padding: new EdgeInsets.all(20.0),
          color: Colors.blueAccent,
          height: 250.0,
          // width: MediaQuery.of(ctx).size.width,
          child: new Stack(children: <Widget>[
            new Image.network("https://placeimg.com/900/600/nature", fit: BoxFit.cover,), 
            new Center( child: new Column(children: <Widget>[
              new Padding(padding: new EdgeInsets.all(20.0)),
              CircleAvatar(
                radius: 30.0,
                // backgroundImage: new NetworkImage(user.picture)
                ),
              new Padding(padding: new EdgeInsets.all(20.0)),
              new Text("test", 
                  textDirection: TextDirection.ltr,
                  style: new TextStyle(
                  fontSize: 30.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              )
              ]))
          ]
        ));
    
  }

class FirstPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new ListView.builder(
      itemCount: 50,
      itemBuilder: (context, index){
        return ListTile(title: Text("tesdfsaf"),);
      }
    );
  }
}

class SecondPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Container(
      child: new Center(
        child: new Icon(Icons.favorite,  size: 100.0, color:
        Colors.brown)
      )
    );
  }
}