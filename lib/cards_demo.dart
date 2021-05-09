//https://flutter.dev/docs/development/ui/layout#card

import 'package:flutter/material.dart';

class CardsDemo extends StatefulWidget {
  @override
  _CardsDemoState createState() => _CardsDemoState();
}

class _CardsDemoState extends State<CardsDemo> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _getAppBar() as PreferredSizeWidget?,
      body: _getBody(),
    );
  }

  Widget _getAppBar() {
    return AppBar(
      title: Text("Card Demo"),
    );
  }

  Widget _getBody() {
    return _buildCard1();
  }

  Widget _buildCard1() {
    var size = MediaQuery.of(context).size;
    return SizedBox(
      height: 250,
      child: Card(
        margin: EdgeInsets.all(8),
        child: Column(
          children: [
            ListTile(
              leading: Icon(Icons.restaurant_menu, color: Colors.blue[500]),
              title: Text('1625 Main Street',
                  style: TextStyle(fontWeight: FontWeight.w500)),
              subtitle: Text('My City, CA 99984'),
            ),
            Divider(),
            ListTile(
              leading: Icon(Icons.contact_phone, color: Colors.blue[500]),
              title: Text('(408) 555-1212',
                  style: TextStyle(fontWeight: FontWeight.w500)),
              subtitle: Text('Mobile'),
            ),
            ListTile(
              leading: Icon(Icons.contact_mail, color: Colors.blue[500]),
              title: Text('costa@example.com',
                  style: TextStyle(fontWeight: FontWeight.w500)),
              subtitle: Text('Office email'),
            ),
          ],
        ),
      ),
    );
  }
}
