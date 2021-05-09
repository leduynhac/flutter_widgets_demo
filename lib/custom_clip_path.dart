//https://www.developerlibs.com/2019/08/flutter-draw-custom-shaps-clip-path.html

import 'package:flutter/material.dart';

class CustomClipPath extends StatefulWidget {
  @override
  _CustomClipPathState createState() => _CustomClipPathState();
}

class _CustomClipPathState extends State<CustomClipPath> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _getAppBar() as PreferredSizeWidget?,
      body: _getBody()
    );
  }

  Widget _getAppBar(){
    return AppBar(
      title: Text("Custom Shapes"),
    );
  }

  Widget _getBody(){
    var size = MediaQuery.of(context).size;
    return ClipPath(
      child: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Container(
          height: size.height * 0.5,
          decoration: BoxDecoration(
            color: Colors.yellow,
            boxShadow: [
              BoxShadow(
                spreadRadius: 5,
                blurRadius: 1,
                color: Colors.grey
              ),
            ]
          ),
        ),
      ),
      clipper: OvalBottomClipper(),
    );    
  }
}

class OvalBottomClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    path.lineTo(0, size.height - 100);
    path.quadraticBezierTo(
        size.width / 2, size.height, size.width, size.height - 100);
    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return true;
  }
}
