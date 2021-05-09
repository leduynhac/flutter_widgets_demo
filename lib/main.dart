import 'package:flutter/material.dart';
import 'package:flutter_widgets_demo/cache_network_image.dart';
import 'package:flutter_widgets_demo/cards_demo.dart';
import 'package:flutter_widgets_demo/circle_oval_drawer.dart';
import 'package:flutter_widgets_demo/custom_clip_path.dart';
import 'package:flutter_widgets_demo/shadow_drawer.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: _getHome(),
    );
  }
}

Widget _getHome(){
  //return CircleOvalDrawer();
  //return ShadowDrawer();
  //return CacheNetWorkImageDemo();
  //return CardsDemo();
  return CustomClipPath();
}
