import 'package:flutter/material.dart';
import 'package:share/share.dart';

class GifPage extends StatelessWidget {

  final Map _gidData;

  GifPage(this._gidData);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_gidData["title"]),
          backgroundColor: Colors.black,
        actions: <Widget>[
          IconButton(icon: Icon(Icons.share),
          onPressed: (){
            Share.share(_gidData["images"]["fixed_height"]["url"]);
          },)
        ],
      ),
      backgroundColor: Colors.black,
      body: Center(
        child: Image.network(_gidData["images"]["fixed_height"]["url"]),
      ),
    );
  }
}
