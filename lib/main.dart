import 'package:flutter/material.dart';
import 'extended_text_field.dart';
import 'rounded_image.dart';
import 'bottom_app_bar.dart';
import 'google_tasks_bottom_bar.dart';
import 'sliver.dart';
import 'datepicker_component.dart';
import 'timepicker_component.dart';
import 'staggered_tile.dart';
import 'scoped_model.dart';
import 'tab_examples.dart';
import 'package:flutter_ui_experiments/map-ui-example.dart';
import 'json-example.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'webview_example.dart';


void main() {
  runApp(new MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => new _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // static const Curve scrollCurve = Curves.fastOutSlowIn;
  final PageController controller = new PageController();
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'UI Experiments',
      theme: new ThemeData(
        primarySwatch: Colors.blue,
      ),
      routes: {
        '/bottom_app_bar': (context) => new BottomAppBarPage(),
        '/bottom_app_bar_google': (context) => new GoogleTasksBottomAppBarPage(),
        '/widget': (_) => new WebviewScaffold(
              url: "https://www.youtube.com",
              appBar: new AppBar(
                title: const Text('Widget webview static'),
              ),
              withZoom: true,
              withLocalStorage: true,
            )
      },
      home: new Scaffold(
        // body: new ImageTileGridPage(),
        body: new PageView(
          controller: controller,
          onPageChanged: (index) => setState(() => _selectedIndex = index),
          children: <Widget>[
            // new MyHomePage(title: 'Home'),
            // new RoundedImageScreen(),
            new SliverSamplePage(title: "Sliver example"),
            // new BottomBarHomePage(),
            new MapScreen(),
            // new ImageTileGridPage(),
            new JsonPage(),
            // new WebViewScreen(),
            new MyScopedModelWidget(), 
            // new MyTabs()
          ],
        ),
        bottomNavigationBar: new BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          currentIndex: _selectedIndex,
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
          items: <BottomNavigationBarItem>[
            new BottomNavigationBarItem(
              icon: new Icon(Icons.home),
              title: new Text('Home'),
            ),
            new BottomNavigationBarItem(
              icon: new Icon(Icons.image),
              title: new Text('Image'),
            ),
            new BottomNavigationBarItem(
              icon: new Icon(Icons.content_cut),
              title: new Text('Sliver'),
            ),
            new BottomNavigationBarItem(
              icon: new Icon(Icons.border_horizontal),
              title: new Text('App Bar'),
            ),
          ],
        ),
      ),
    );
  }
}

class MyHomePage extends StatelessWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text(title),
      ),
      body: new Center(
        child: new Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            new ExtendedTextField(
              hintText: 'Center aligned hint text :D',
              textAlign: TextAlign.center,
            ),
            new DatePicker(),
            new TimePicker(),
          ],
        ),
      ),
    );
  }
}
