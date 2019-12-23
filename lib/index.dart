import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  Future<List<Post>> _getPost() async {
    var data = await http.get("https://jsonplaceholder.typicode.com/posts/");
    var jsonData = json.decode(data.body);

    List<Post>  posts = [];
    for (var js in jsonData)
    {
      Post post = Post(js['title'],js['body']);
      posts.add(post);

    }

    return posts;

  
  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp
    (
      home: Scaffold(
        appBar:  new AppBar(
          title: Text("My Rest Api App"),
        ),

        body: Container(


      child: FutureBuilder(
        future: _getPost(),
        builder: (BuildContext context , AsyncSnapshot snapshot){

          if(snapshot.data == null)
          {
            return Container(
              child: Center(
                child:Text("Loading ......")
                ),
            );

          }
          else{

            return  ListView.builder(
              itemCount: snapshot.data.length,
              itemBuilder: (BuildContext content, int index){
                return ListTile(
                  title: Text(snapshot.data[index].title),

                  onTap: (){
                    Navigator.push(context, 
                    new MaterialPageRoute(builder: (context)=> PostDetail(snapshot.data[index])));
                  },
                );
              },

            );

          }
        },
      ),

        ),
      )

      
    );
  }
}


class PostDetail extends StatelessWidget {
 // const PostDetail({Key key}) : super(key: key);

  final Post post;

  PostDetail(this.post);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text(post.title),
        ),
        body: Container(
          child: Column(
            children:<Widget>[

              Padding(
                padding: EdgeInsets.all(10),
                child:Text(post.body, style: TextStyle(color: Colors.blue, fontSize: 20.0),),

              )
              

            ] 
          ),
        ) 
        ),
    );
  }
}

class Post{

    final String title;
    final String  body;

    Post(this.title, this.body);

  }


