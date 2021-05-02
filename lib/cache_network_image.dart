//https://flutter.dev/docs/cookbook/images/cached-images

import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

class CacheNetWorkImageDemo extends StatefulWidget {
  @override
  _CacheNetWorkImageDemoState createState() => _CacheNetWorkImageDemoState();
}

class _CacheNetWorkImageDemoState extends State<CacheNetWorkImageDemo> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _getAppBar() as PreferredSizeWidget?,
      body: _getBody(),
    );
  }

  Widget _getAppBar(){
    return AppBar(
      title: Text("Cached Images"),
    );
  }

  Widget _getBody(){
    return Center(
      child: CachedNetworkImage(
        imageUrl: 'https://picsum.photos/250?image=9',
        placeholder: (context, url) => CircularProgressIndicator(),
      ),
    );
  }
}