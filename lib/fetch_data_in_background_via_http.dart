import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

//Refs
// - https://flutter.dev/docs/cookbook/networking/background-parsing

class Photo{
  final int albumId;
  final int id;
  final String title;
  final String url;
  final String thumbnailUrl;

  Photo({
    required this.albumId,
    required this.id,
    required this.title,
    required this.url,
    required this.thumbnailUrl
  });

  factory Photo.fromJson(Map<String, dynamic> json){
    return Photo(
      albumId: json['albumId'] as int,
      id: json['id'] as int,
      title: json['title'] as String,
      url: json['url'] as String,
      thumbnailUrl: json['thumbnailUrl'] as String,
    );
  }
}

List<Photo> parsePhotos(String responseBody){
  print('responseBody: $responseBody');
  // print: responseBody: [
  //   {
  //     "albumId": 1,
  //     "id": 1,
  //     "title": "accusamus beatae ad facilis cum similique qui sunt",
  //     "url": "https://via.placeholder.com/600/92c952",
  //     "thumbnailUrl": "https://via.placeholder.com/150/92c952"
  //   },
  //   {
  //     "albumId": 1,
  //     "id": 2,
  //     "title": "reprehenderit est deserunt velit ipsam",
  //     "url": "https://via.placeholder.com/600/771796",
  //     "thumbnailUrl": "https://via.placeholder.com/150/771796"
  //   },
  //   ...
  // ]  
  // final parsed = jsonDecode(responseBody).cast<Map<String, dynamic>>(); // return List<Map<String, dynamic>>
  final parsed = jsonDecode(responseBody);// return List<dynamic>
  return parsed.map<Photo>((json) => Photo.fromJson(json)).toList();
}

Future<List<Photo>> fetchPhotos(http.Client client) async{
  final response = await client.get(Uri.parse('https://jsonplaceholder.typicode.com/photos'));

  // Not use the compute function to run parsePhotos in a separate isolate.
  // => Result in poor app performance or stuttering animations, often called “jank.”
  // return parsePhotos(response.body);

  // Use the compute function to run parsePhotos in a separate isolate
  // to avoid jank.
  return compute(parsePhotos, response.body);
}

class FetchDataInBackgoundViaHttp extends StatefulWidget {
  const FetchDataInBackgoundViaHttp({ Key? key }) : super(key: key);

  @override
  _FetchDataInBackgoundViaHttpState createState() => _FetchDataInBackgoundViaHttpState();
}

class _FetchDataInBackgoundViaHttpState extends State<FetchDataInBackgoundViaHttp> {

  late Future<List<Photo>> _futurePhotos;

  @override
  void initState() {
    super.initState();
    _futurePhotos = fetchPhotos(http.Client());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Fetch big data in background'),
      ),
      body: _getBody(),
    );
  }

  Widget _getBody(){
    return FutureBuilder<List<Photo>>(
      future: _futurePhotos,
      builder: (context, snapshot){
        if (snapshot.hasError) print(snapshot.error);

        return snapshot.hasData
        ? PhotosList(photos: snapshot.data!)
        : Center(child: CircularProgressIndicator());
      },
    );
  }
}

class PhotosList extends StatelessWidget {
  const PhotosList({ Key? key, required this.photos }) : super(key: key);
  final List<Photo> photos;


  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2
      ),
      itemCount: photos.length,
      itemBuilder: (context, index){
        return Image.network(photos[index].thumbnailUrl);
      });
  }
}