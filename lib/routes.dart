import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'google_tasks_bottom_bar.dart';
// import 'webview_example.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'bottom_app_bar.dart';
import 'create_user_one.dart';
import 'create_user_two.dart';

class Routes {
  var _routes;

  Map<String, WidgetBuilder> get routes => _routes;

  Routes(BuildContext context) {
    _routes = <String, WidgetBuilder>{
      '/bottom_app_bar': (context) => new BottomAppBarPage(),
        '/bottom_app_bar_google': (context) => new GoogleTasksBottomAppBarPage(),
        '/widget': (_) => new WebviewScaffold(
              url: "https://www.youtube.com",
              appBar: new AppBar(
                title: const Text('Widget webview static'),
              ),
              withZoom: true,
              withLocalStorage: true,
          ),
        '/form1' : (context) => new CreateUserFormPageOne(),
        '/form2' : (context) => new CreateUserFormPageTwo()
    };
  }
}

