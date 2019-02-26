import 'dart:async';
import 'package:flutter/material.dart';
import 'dart:io';
import 'dart:math' as math;
import 'routes.dart';
import 'package:parse_fullstack/login_service.dart';
import 'package:parse_fullstack/parse_rest_service.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:parse_fullstack/user_list.dart';
import 'package:parse_fullstack/models/city.dart';

// https://codelabs.developers.google.com/codelabs/flutter-firebase/
class CitiesListScreen extends StatefulWidget {
  final String currentUserId ;
  CitiesListScreen({Key key, this.currentUserId}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState(currentUserId);
}

class _MyHomePageState extends State<CitiesListScreen> {

  String _currentUserId;
  LoginService loginService = new LoginService();

  // final GlobalKey<ScaffoldKey> _scaffoldKey = new GlobalKey<ScaffoldKey>()
  final GlobalKey<FormState> _formKey = new GlobalKey<FormState>();
  final TextEditingController _nameController = new TextEditingController();
  final ParseService parseService = new ParseService();

  _MyHomePageState(String currentUserId){
    _currentUserId = currentUserId;
  }

  void _logout() async {
    WidgetBuilder homePage = Routes(context).routes["/"];
    await loginService.logout(); 
    // Navigator.popUntil(context, ModalRoute.withName("/"));
    Navigator.pushNamedAndRemoveUntil(context, "/", (Route<dynamic> route) => false);
  }

  @override
  void initState() {
    super.initState();
  }
  
  @override
  void dispose() {
      _nameController.dispose();
      super.dispose();
    }
  
  // TODO 
  void resetCity() {

  }

  Widget buildCityItem(Map<String, String> city){

    String image = city["image"];
    String cityName = city["city"];
    String country = city["country"];
    String cityId = city["cityId"];

    return Card(
      child: Stack(
        children: <Widget>[
          Container(
            height: 250.0,
            width: 170.0,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: CachedNetworkImageProvider(image),
                fit: BoxFit.cover
              )
            ),
          ), // image
          Container(  // row of text same height
            height: 250.0,
            width: 170.0,
            child: Text("test",style: TextStyle(color: Colors.white),),
          )
        ],
      )
    );
  }
  
  Widget buildHorizontalList(List<Map<String, String>> list) {
    return ListView.builder(
      itemCount: list.length,
      scrollDirection: Axis.horizontal,
      itemBuilder: (context, idx){
        return buildCityItem(list[idx]);
      },
    );
  }
  
  Widget buildTitle({city: String, country: String}){
    return Container(
      alignment: Alignment.bottomLeft,
      decoration: BoxDecoration(
        color: Colors.black54
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(city, textAlign: TextAlign.left, style: TextStyle(color: Colors.white, fontSize: 18.0,fontWeight: FontWeight.bold)),
          Text(country, textAlign: TextAlign.left, style: TextStyle(color: Colors.white, fontSize: 12.0,fontWeight: FontWeight.normal)),
      ])
    );

  }
  
  // https://docs.flutter.io/flutter/painting/BoxDecoration-class.html
  Widget buildUserItem(Map<String, String> city){
    String image = city["image"];
    String cityName = city["city"];
    String country = city["country"];
    String cityId = city["cityId"];

    return Padding(
      padding: EdgeInsets.symmetric(horizontal:10.0),
      child: GestureDetector(
        onTap: (){ Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => UserListScreen(cityId: cityId, cityName: cityName)),
          );
        },
        child: Card(
          elevation: 2.0,
          child: Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: CachedNetworkImageProvider(image),
                fit: BoxFit.cover
              )
            ),
            child: buildTitle(city: cityName, country: country) 
            // child: Text("test"),
          )
        )
      )
    );
  }


  Widget buildUserList(List<Map<String,String>> cityList){
    return ListView.builder(
      itemExtent: 300.0,
      itemCount: cityList.length,
      itemBuilder: (context, index) {
        return buildUserItem(cityList[index]); 
      },
    );
  }

  Widget buildBodyList(){
    // TODO return map of lists (users, city)
    // return FutureBuilder<Map<List<Map<String,String>>>>(
    return FutureBuilder<List<Map<String,String>>>(
      future: parseService.getCityList(), // parseService.getUserList(currentCity)
      initialData: [{"image":"","city":"","country":"","cityId":""}],
      builder: (BuildContext context, AsyncSnapshot snapshot){
        if(snapshot.hasData && snapshot.connectionState == ConnectionState.done){
          var snapList = snapshot.data;
          print("CITY $snapList");

          // https://medium.com/flutter-io/slivers-demystified-6ff68ab0296f
          return CustomScrollView(
            scrollDirection: Axis.vertical,
            slivers: <Widget>[
              SliverAppBar(title: Text("Top Cities")),
              SliverPersistentHeader(
                delegate: _SliverAppBarDelegate(
                  minHeight: 170.0,
                  maxHeight: 200.0,
                  // child: Container(
                  //     color: Colors.lightBlue, child: Center(child:
                  //         Text("text"))),
                  child: buildHorizontalList(snapList),
                ),
              ),
              SliverAppBar(title: Text("Local Hosts")),
              SliverList(
                delegate: SliverChildBuilderDelegate((context,index){
                  return Container(
                    child: buildUserItem(snapList[index])
                  );
                }, childCount: snapList.length),
              )
            ],
          );
        }
        return Center(child:CircularProgressIndicator());
      },
    );
  }

  Widget buildBody() {
    return FutureBuilder<List<Map<String, String>>>(
      future: parseService.getCityList(),
      builder: (context, snapshot){
        if(snapshot.hasData && snapshot.connectionState == ConnectionState.done){
          var list = snapshot.data;
          return SingleChildScrollView(
            child: Column(
              children: <Widget>[
                Text("Top Cities"),
                buildHorizontalList(list),
                Text("Local hosts"),
                buildUserList(list),
              ],
            ),
          );
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
          appBar: AppBar(
            // title: Text(_currentUserId),
            title: Text('test'),
            actions: <Widget>[ 
              IconButton(
                icon: Icon(Icons.cancel),
                onPressed: (){ 
                  _logout();
                },
              )
            ],
          ),
      body: buildBodyList(),
      // body: buildBody(),
      persistentFooterButtons: <Widget>[
        Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            // https://stackoverflow.com/questions/53586892/flutter-textformfield-hidden-by-keyboard
            SizedBox(
              width: MediaQuery.of(context).size.width - 70.0,
              child: TextFormField(
                controller: _nameController,
                decoration: InputDecoration(
                  hintText: "Type here...",
                  contentPadding: EdgeInsets.symmetric(horizontal: 20.0),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(32.0)
                  ),
                ),
              )
            ),
            IconButton(
              icon: Icon(Icons.send),
              onPressed: (){
                if(_nameController.text.isNotEmpty){
                  // parseSDKService.sendMessage({"message": _nameController.text.toString()});
                  print(_nameController.text);
                }
              },
            ),
            // SizedBox(width: 100.0,)
          ],
        ),
      ],
    );
  }
}

class _SliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  _SliverAppBarDelegate({
    @required this.minHeight,
    @required this.maxHeight,
    @required this.child,
  });
  final double minHeight;
  final double maxHeight;
  final Widget child;
  @override
  double get minExtent => minHeight;
  @override
  double get maxExtent => math.max(maxHeight, minHeight);
  @override
  Widget build(
      BuildContext context, 
      double shrinkOffset, 
      bool overlapsContent) 
  {
    return new SizedBox.expand(child: child);
  }
  @override
  bool shouldRebuild(_SliverAppBarDelegate oldDelegate) {
    return maxHeight != oldDelegate.maxHeight ||
        minHeight != oldDelegate.minHeight ||
        child != oldDelegate.child;
  }
}