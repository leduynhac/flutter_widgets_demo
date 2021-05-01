import 'package:flutter/material.dart';

class ShadowDrawer extends StatefulWidget {
  @override
  _ShadowDrawerState createState() => _ShadowDrawerState();
}

class _ShadowDrawerState extends State<ShadowDrawer> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _getAppBar(),
      body: _getBody(),
    );
  }

  _getAppBar() {
    return AppBar(
      title: Text("Shadow Drawer"),
    );
  }

  _getBody() {
    var size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Container(
        width: size.width,
        height: size.height / 2,
        decoration: BoxDecoration(
          color: Colors.red,
          boxShadow: [
            BoxShadow(
              spreadRadius: 10,
              blurRadius: 5,
              color: Colors.yellow.withOpacity(1),
            )
          ],
        ),
        child: Column(
          children: [
            Text("text1"),
            Text("text2")
          ],
        ),
      ),
    );
  }
}
