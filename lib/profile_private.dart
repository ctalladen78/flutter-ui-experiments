import 'package:flutter/material.dart';
import 'api_service.dart';

class PrivateProfile extends StatefulWidget {
  
  _PrivateProfileState createState() => _PrivateProfileState();
}

// TODO embed 3 textformfields that uses google places api, creates places object, saves places object to firebase
// tabs : contacts, past trips, offers
// main application tab : cities list => user list(city) , create new trip, private profile, messages 
class _PrivateProfileState extends State<PrivateProfile> {
  ApiService apiService = new ApiService();
  final GlobalKey avatarRowKey = GlobalKey();
// final screenHeight = MediaQuery.of(context).size.height;

  Widget _getUserImage(){
    Widget avatar = apiService.getUserImage();
    if(avatar == null){
      print('NULL');
      return apiService.getDefaultAvatar();
    }
    return avatar;
  }

  Widget _buildAvatarSection() {
    return Padding(
            key: avatarRowKey,
            padding: EdgeInsets.all(10.0),
            child: Row(
              children: <Widget>[
                _getUserImage(),
                Padding(
                  padding: EdgeInsets.only(left: 10.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        'Testing Name',
                        style: TextStyle(
                          fontSize: 22.0,
                          color: Colors.grey.shade800,
                        ),
                      ),
                      Text(
                        '@testing_username',
                        style: TextStyle(
                          fontSize: 13.0,
                          color: Colors.grey.shade800,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
  }

  Widget _buildMapSection() {
    // map section
    return Padding(
      padding: EdgeInsets.all(10.0),
      child: Container(
        height: 200,
        width: MediaQuery.of(context).size.width,
        child: apiService.buildStaticMap(latitude: "testLat", longitude: "testLong", width: 300, height: 200),
      ),
    );
  }

  // TODO private profile: view profile button, edit profile button
  // TODO public profile: add to contacts button, send an offer
  Widget _buildBioSection() {

  }

  Widget _buildTabSection() {
    return DefaultTabController(
            length: 3,
            // child: SizedBox(
              // height: MediaQuery.of(context).size.height - padding height,
              // height: 500.0,
              // height: screenHeight - avatarRowHeight,
              child: Column(            
                children: <Widget>[
                  // https://stackoverflow.com/questions/50566868/how-to-change-background-color-of-tabbar-without-changing-the-appbar-in-flutter
                  // https://camposha.info/flutter/nested-tabs
                TabBar(
                  labelColor: Colors.redAccent[300],
                  // indicator: ,
                  indicatorColor: Colors.amberAccent[300],
                  tabs: <Widget>[
                    Tab(
                      text: "Contacts",
                      // icon: Icon(Icons.ac_unit)
                      ),
                    Tab(
                      text: "Notifications",
                    ),
                  ],
                ),
                Container(
                  height: 300,
                  child: TabBarView(
                // TabBarView(
                  children: <Widget>[
                    Container(
                      height: 100.0,
                      // width: 100.0,
                      width: MediaQuery.of(context).size.width,
                      color: Colors.grey,
                      child: ListView.builder(
                        itemCount: 50,
                        itemBuilder: (BuildContext context, int index){
                          // _itemBuilder(context, index);
                          return new ListTile(
                            // leading: new CircleAvatar(backgroundImage: new NetworkImage(profile)),
                            title: new Text("name"),
                            subtitle: new Text("profile"),
                            trailing: Icon(Icons.delete),
                          );
                        },
                      ),
                    ),
                    Container(
                      color: Colors.green,
                    ),
                    Container(
                      color: Colors.purple,
                    ),
                  ],
                  ),
                )
              
              ],
            ),
      // ),
          );
  }

  Widget _buildScaffold() {
    return Scaffold(
      
      body: SingleChildScrollView(
        child: Column(
        children: <Widget>[
          _buildAvatarSection(),
          
          _buildMapSection(),
          
          _buildTabSection(),
        ],
      ),
      )
    );
  }

  @override
  Widget build(BuildContext context) {
    return _buildScaffold();
    
  }
}

class TripWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListTile(
        // leading: new CircleAvatar(backgroundImage: new NetworkImage(profile)),
        title: new Text("name"),
        subtitle: new Text("profile"),
        trailing: Icon(Icons.delete),
      )
    );
  }
}