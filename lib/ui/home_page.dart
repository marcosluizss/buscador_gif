import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:share/share.dart';
import 'package:transparent_image/transparent_image.dart';
import 'gif_page.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String _search;
  int _limit;
  int _offset;
  String _url;

  Future<Map> _getGifs() async {
    http.Response response;

    if (_search == null || _search.isEmpty) {
      _url =
          "https://api.giphy.com/v1/gifs/trending?api_key=5ojJOBmwdXqyjLXX5rbK87aOrHW4o6LE&limit=$_limit&rating=G";
    } else {
      _url =
          "https://api.giphy.com/v1/gifs/search?api_key=5ojJOBmwdXqyjLXX5rbK87aOrHW4o6LE&q=$_search&limit=19&offset=$_offset&rating=G&lang=en";
    }

    response = await http.get(_url);
    return json.decode(response.body);
  }

  @override
  void initState() {
    super.initState();

    /*_getGifs().then((map) {
      print(map);
    });*/
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Image.network(
            "https://developers.giphy.com/static/img/dev-logo-lg.7404c00322a8.gif"),
        centerTitle: true,
      ),
      backgroundColor: Colors.black,
      body: Column(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.all(10.0),
            child: TextField(
              decoration: InputDecoration(
                  labelText: "Pesquise Aqui",
                  labelStyle: TextStyle(color: Colors.white),
                  border: OutlineInputBorder()),
              style: TextStyle(color: Colors.white, fontSize: 18.0),
              textAlign: TextAlign.center,
              onSubmitted: (text){
                setState(() {
                  _search = text;
                  _offset = 0;
                });
              },
            ),
          ),
          Expanded(
            child: FutureBuilder(
              future: _getGifs(),
                builder: (context, snapshot){
                  switch(snapshot.connectionState){
                    case ConnectionState.none:
                    case ConnectionState.waiting:
                      return Container(alignment: Alignment.center, width: 200, height: 200,child: CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                      ),
                      );
                    default:
                      if(snapshot.hasError){
                        return Container();
                      }else{
                        return _createGifTable(context, snapshot);
                      }
                  }
                }
            ),
          )
        ],
      ),
    );
  }

  int _getCount(List data){
    if(_search == null || _search.isEmpty){
      return data.length;
    }else{
      return data.length+1;
    }
  }

  Widget _createGifTable(BuildContext context, AsyncSnapshot snapshot){
    return GridView.builder(
        padding: EdgeInsets.all(10.0),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 10.0,
            mainAxisSpacing: 10.0
        ),
        itemCount: _getCount(snapshot.data["data"]),
        itemBuilder: (context, index){
          if(_search == null || _search.isEmpty || index < snapshot.data["data"].length) {
            return GestureDetector(
                child: FadeInImage.memoryNetwork(placeholder: kTransparentImage, image: snapshot
                    .data["data"][index]["images"]["fixed_height"]["url"],height: 300,fit: BoxFit.cover,),
              onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context){return GifPage(snapshot
                      .data["data"][index]);}));
              },
              onLongPress: (){
                Share.share(snapshot.data["data"][index]["images"]["fixed_height"]["url"]);
              },
            );
          }else{
            return Container(
              child: GestureDetector(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Icon(Icons.add,color: Colors.white, size: 70.0,),
                    Text("Carregar mais...", style: TextStyle(color: Colors.white, fontSize: 22.0),)
                  ],
                ),
                onTap: (){
                  setState(() {
                    _offset += 19;
                  });
                },
              ),
            );
          }
        });
  }
}
