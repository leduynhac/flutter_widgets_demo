import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter_widgets_demo/my_custom_clipper.dart';

class CircleOvalDrawer extends StatefulWidget {
  @override
  _CircleOvalDrawerState createState() => _CircleOvalDrawerState();
}

class _CircleOvalDrawerState extends State<CircleOvalDrawer> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _getAppBar() as PreferredSizeWidget?,
      body: _getBody(),
    );
  }

  Widget _getAppBar() {
    return AppBar(
      title: Text("Circle & Oval drawer"),
    );
  }

  Widget _getBody() {
    var size = MediaQuery.of(context).size;
    return Container(
      width: size.width,
      height: size.height,
      child: Column(
        children: [
          _getCircle1(),
          SizedBox(
            height: 10,
          ),
          _getCircle2(),
          SizedBox(
            height: 10,
          ),
          _getClipOval(),
        ],
      ),
    );
  }

  Widget _getCircle1() {
    return Container(
      width: 100,
      height: 100,
      decoration: ShapeDecoration(shape: CircleBorder(), color: Colors.blue),
    );
  }

  Widget _getCircle2() {
    return Container(
        width: 100,
        height: 100,
        decoration: BoxDecoration(color: Colors.red, shape: BoxShape.circle));
  }

  Widget _getClipOval() {
    return ClipOval(
      child: Image.asset('assets/images/img_1.jpeg'),
    );
  }
}
