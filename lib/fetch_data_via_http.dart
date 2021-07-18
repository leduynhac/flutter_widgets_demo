import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

//Refs:
// - https://flutter.dev/docs/cookbook/networking/fetch-data

// Create an Album class that contains the data from the network request.
class Album{
  final int userId;
  final int id;
  final String title;

  Album({
    required this.userId,
    required this.id,
    required this.title,
  });

  factory Album.fromJson(Map<String, dynamic> json){
    return Album(
      userId: json['userId'],
      id: json['id'],
      title: json['title']
    );
  }
}

Future<Album> fetchAlbum(http.Client client) async{
  final response = await client.get(
    Uri.parse('https://jsonplaceholder.typicode.com/albums/1'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
  );

  if (response.statusCode == 200){
    // If the server did return a 200 OK response
    // then parse the JSON
    return Album.fromJson(jsonDecode(response.body));
  }else{
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load album');
  }
}

class FetchDataViaHttp extends StatefulWidget {
  const FetchDataViaHttp({ Key? key }) : super(key: key);

  @override
  _FetchDataViaHttpState createState() => _FetchDataViaHttpState();
}

class _FetchDataViaHttpState extends State<FetchDataViaHttp> {

  late http.Client _client;
  late Future<Album> _futureAlbum;

  @override
  void initState() {
    super.initState();
    _client = http.Client();
    _futureAlbum = fetchAlbum(_client);
  }

  @override
  void dispose() {
    _client.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Fetch data via http package'),
      ),
      body: _getBody(),
    );
  }

  Widget _getBody(){
    return Center(
      child: FutureBuilder<Album>(
        future: _futureAlbum,
        builder: (context, snapshot){
          if (snapshot.hasData){
            return Text(snapshot.data!.title);
          }else if(snapshot.hasError){
            return Text("${snapshot.error}");
          }

        // By default, show a loading spinner
        return CircularProgressIndicator();        
        }),
    );    
  }
}