import 'package:flutter/material.dart';
import 'package:buscador_gif/ui/home_page.dart';

//5ojJOBmwdXqyjLXX5rbK87aOrHW4o6LE

//https://api.giphy.com/v1/gifs/trending?api_key=5ojJOBmwdXqyjLXX5rbK87aOrHW4o6LE&limit=20&rating=G
//https://api.giphy.com/v1/gifs/search?api_key=5ojJOBmwdXqyjLXX5rbK87aOrHW4o6LE&q=dogs&limit=20&offset=0&rating=G&lang=en

void main(){
  runApp(MaterialApp(
    home: HomePage(),
    theme: ThemeData(hintColor: Colors.white),
  ));
}
