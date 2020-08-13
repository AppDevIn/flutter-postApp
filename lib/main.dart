import 'package:flutter/material.dart';
import 'Widgets/listView.dart';
import 'class/post.dart';
import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';
import 'package:http/http.dart' as http;

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Welcome to Flutter',
      home: Scaffold(
        appBar: AppBar(
          title: const Text("Overflow"),
          actions: <Widget>[
            IconButton(icon: const Icon(Icons.add), tooltip: "Add post", onPressed: null)
          ],
        ),
        body: Container(
          child: Center(
            child: FutureBuilder<List<Post>>(
              future: generatePost(),
              builder: (context, AsyncSnapshot<List<Post>> snapshot) {
                if (snapshot.hasData) {
                  return PostView(snapshot.data);
                } else {
                  return CircularProgressIndicator();
                }
              },
              )

          ),

        ),
      ),
    );
  }
}


Future<List<Post>> generatePost () async{

 http.Response response = await http.get(
        'https://i.ytimg.com/vi/RNRN7tW1Vgg/maxresdefault.jpg',
      );

  String _base64 = base64Encode(response.bodyBytes);
  Uint8List bytes = base64Decode(_base64);

  List<Post> posts = new List<Post>();
  for (int i = 0; i < 5; i++){
    posts.add(new Post(name: "inori yuzuriha", imageCode: bytes));
  }

  return posts;
}

