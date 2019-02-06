import 'package:flutter/material.dart';
import 'package:james_childrens_app/services/login_service.dart' ;
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:james_childrens_app/services/model_builder.dart' show ModelBuilder, AppModel;
import 'package:james_childrens_app/models/user.dart';
import 'package:scoped_model/scoped_model.dart' as scopedModel;
import "package:james_childrens_app/models/book.dart";
import 'package:james_childrens_app/book_detail.dart';
import 'package:james_childrens_app/new_book_form.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:james_childrens_app/book_category.dart';


class ProfileScreen extends StatefulWidget {
  @override
  State createState() => new ProfileScreenState();
}

class ProfileScreenState extends State<ProfileScreen> {
  ModelBuilder _modelBuilder; // get user info from db
  LoginService _loginService; // _loginService.googleLogout()

  @override
  void initState() {
    super.initState();
    _modelBuilder = new ModelBuilder();
    // _modelBuilder.deleteAll();
  }

  Future<Null> _launchInBrowser(String url) async {
    if (await canLaunch(url)) {
      await launch(url, forceSafariVC: true, forceWebView: true, enableJavaScript: true);
    } else {
      throw 'Could not launch $url';
    }
  }

  // future builder, 
  Widget _buildProfileHeader(){
    return new FutureBuilder(
      future: _modelBuilder.getUserProfile(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        User user = snapshot.data;
        print("SNAP USER $user");
        if(!snapshot.hasData){ return new Center(child: new CircularProgressIndicator());}
        return new Container(
          // padding: new EdgeInsets.all(20.0),
          color: Colors.blueAccent,
          height: 250.0,
          child: new Stack(children: <Widget>[
            new Image.network("https://placeimg.com/900/600/nature", fit: BoxFit.cover,), 
            new Center( child: new Column(children: <Widget>[
              new Padding(padding: new EdgeInsets.all(20.0)),
              new GestureDetector(
                onTap: (){_launchInBrowser(user.link);},
                child: CircleAvatar(
                radius: 30.0,
                backgroundImage: new NetworkImage(user.picture)),
                // backgroundColor: Colors.blueAccent),
              ),
              new Padding(padding: new EdgeInsets.all(20.0)),
              new Text(user.name, 
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
    );
  }

  Widget _buildBookThumbnail(Book book){
    return new GestureDetector( 
      onTap:(){
        Navigator.push(context, new MaterialPageRoute(
                  builder : (context) => new BookDetailScreen()
                ));
      },
      child: new Container(
          width: 150.0,
          margin: new EdgeInsets.all(5.0),
          child: new Column(
            children: <Widget>[
              new Image.network(book.preview, 
                // fit: BoxFit.cover, 
                // width: 50.0, 
                height: 100.0,
              ),
              new Text(book.title),
              new Text(book.author)
            ],
          ),
      )
    );
  }

  // future builder, json books get recent
  Widget _buildHistory(){
    return new FutureBuilder(
      future: _modelBuilder.getBooksByCategory("recent"),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if(!snapshot.hasData){ return new Center(child: new CircularProgressIndicator());}        
        List<Book> list = snapshot.data;
        return new Card( 
          color: Colors.lightBlue,
          child: new Container(
          padding: EdgeInsets.all(10.0),
          height: 250.0,
          child: new Column(
            children: <Widget>[
              new Expanded(child: new Row(
                children: <Widget>[
                  new Padding(
                    padding: new EdgeInsets.only(right: 130.0, left: 10.0), 
                    child: Text("Recently read",
                      style: new TextStyle(
                      fontSize: 22.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      ),
                    )
                  ),
                  new Padding(padding: new EdgeInsets.only(top: 10.0),child: new GestureDetector(
                    child: new Text("See all", style: new TextStyle(color: Colors.black87)),
                    onTap: (){
                      Navigator.push(context, new MaterialPageRoute(
                        builder : (context) => new BookCategoryScreen("recent")
                      ));
                    }
                  ),)
                ],
              )),
              new Container(height: 200.0, child: new ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: snapshot.data.length,
                itemBuilder: (context,  index) {
                  return _buildBookThumbnail(list[index]);
                }
              )
              )
            ],
            )
          )
        );
      },
    );
  }

  void _deleteBook(String title) {
    // _modelBuilder.deleteBook(title)
    // reset state
    print("DELETE BOOK ACTION");
  }
  // future builder , db.getCustombooks
  Widget _buildCustomBookList(){
    return new Container(
      height: 400.0,
      child: new FutureBuilder(
      // future: _modelBuilder.getCustomBookList(),
      future: _modelBuilder.getBooksByCategory("recent"),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if(!snapshot.hasData){ return new Center(child: new CircularProgressIndicator());}        
        // if(!snapshot.hasData) { return new Center(
        //   child: new GestureDetector(
        //     onTap: (){
        //       Navigator.push(context, new MaterialPageRoute(
        //           builder : (context) => new BookCreateScreen()
        //         ));
        //     }, // BookCreateScreen
        //     child: new Icon(Icons.edit),)); }
        return new ListView.builder(
          itemCount:snapshot.data.length,
          itemBuilder: (BuildContext ictx, int idx){
            String title = snapshot.data[idx].title;
            String author = snapshot.data[idx].author;
            String preview = snapshot.data[idx].preview;
            return new ListTile(
              leading: new CircleAvatar(
                backgroundColor: Colors.green,
                backgroundImage: new NetworkImage(preview)
                ),
              title: new Row(
                children: <Widget>[
                  new Expanded(child: new Text(title)),
                  new IconButton(
                    onPressed: (){_deleteBook(title);},
                    icon: new Icon(Icons.delete))
                  ]),
              subtitle: new Text(author)
            );
          }
        );
      }
    ),);
  }

  @override
  Widget build(BuildContext context){
    return  new SingleChildScrollView( // TODO Profile screen Futurebiulder 
        child: new Center(
          child: new Column(
            children: <Widget>[
              // new Stack(), // circleAvatar with background
              _buildProfileHeader(),
              // TODO list view of custom books with edit, delete function
              _buildHistory(),
              _buildCustomBookList(),
              // TODO edit function shows book edit form with
            ],
          ),
        ),
      
    );
  }
}