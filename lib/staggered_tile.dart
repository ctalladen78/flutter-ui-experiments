import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

// (column,row) space occupied out of a total of (4,1-x)
  List<StaggeredTile> _staggeredTiles = const <StaggeredTile>[
    const StaggeredTile.count(2, 2),
    const StaggeredTile.count(2, 1),
    const StaggeredTile.count(1, 2),
    const StaggeredTile.count(1, 1),
    const StaggeredTile.count(2, 2),
    const StaggeredTile.count(1, 2),
    const StaggeredTile.count(1, 1),
    const StaggeredTile.count(3, 1),
    const StaggeredTile.count(1, 1),
    const StaggeredTile.count(4, 1),
  ];

  List<Widget> _tiles = const <Widget>[
    const _ImageTile("https://picsum.photos/200/300/?random"),
    const _ImageTile('https://picsum.photos/201/300/?random'),
    const _ImageTile('https://picsum.photos/202/300/?random'),
    const _ImageTile('https://picsum.photos/203/300/?random'),
    const _ImageTile('https://picsum.photos/204/300/?random'),
    const _ImageTile('https://picsum.photos/205/300/?random'),
    const _ImageTile('https://picsum.photos/206/300/?random'),
    const _ImageTile('https://picsum.photos/207/300/?random'),
    const _ImageTile('https://picsum.photos/208/300/?random'),
    const _ImageTile('https://picsum.photos/209/300/?random'),
  ];

class ImageTileGridPage extends StatefulWidget {
  ImageTileGridPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  ImageTileGridPageState createState() => new ImageTileGridPageState();
}

class ImageTileGridPageState extends State<ImageTileGridPage> {
// class ImageTileGrid extends StatelessWidget{

  @override
  Widget build(BuildContext context){
    return new Scaffold(
      // appBar: new AppBar(title: new Text(widget.title)),
      appBar: new AppBar(title: new Text("title")),
      body: new Padding(
        padding: const EdgeInsets.only(top: 12.0),
        child: new StaggeredGridView.count(
        // child: new StaggeredGridView.extent( // see plugin docs
          // maxCrossAxisExtent: 100.0,
          crossAxisCount: 4,
          staggeredTiles: _staggeredTiles,
          children: _tiles,
          mainAxisSpacing: 4.0,
          crossAxisSpacing: 4.0,
        )
      )
    );
  }
} 

class _ImageTile extends StatelessWidget {
  final String gridImageUrl;

  const _ImageTile(this.gridImageUrl);

  @override
  Widget build(BuildContext context){
    return new Card(
      color: const Color(0x00000000),
      elevation: 3.0,
      child: new GestureDetector(
        onTap: (){
          print("card was tapped");
          print(this.gridImageUrl);
          },
        child: new Container(
          decoration: new BoxDecoration(
            image: new DecorationImage(
              image: new NetworkImage(gridImageUrl),
              fit: BoxFit.cover,
            ),
            borderRadius: new BorderRadius.all(const Radius.circular(10.0)),
          )
        ),
      ),
    );
    
  }
}
