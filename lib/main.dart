import 'dart:async';
import 'dart:convert';
import 'dart:convert' as prefix0;
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  //Get request to the url

  Future<List<User>>  _getusers()  async {

    var data =  await http.get("https://jsonplaceholder.typicode.com/users");
    //decoding the json

    var jsonDecode = json.decode(data.body);

    List<User> users = [];

    for (var item in  jsonDecode)
    {
      User user = User(item['name'],item['email'],item['phone'],item['website']);

      users.add(user);
    }

    return users;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Simple Rest Api'),
        ),
        body: Container(
          padding: EdgeInsets.all(8.0),
          child: FutureBuilder(
            future: _getusers(),
            builder: (BuildContext context, AsyncSnapshot snapshot)
            {
              if(snapshot.data == null)
              {
                return Container(
                  child: Center(
                    child: Text("Loading data ...."),
                  ),
                );
              }

              else 
              {
                return ListView.builder(

                  itemCount: snapshot.data.length,
                  itemBuilder: (BuildContext context, int index){
                    return Card(

                      child:    ListTile(
                      contentPadding: EdgeInsets.all(20),
                      leading: Icon(
                        Icons.account_circle,
                        color: Colors.blue,
                        size: 50.0,

                      ),
                      title: Text(snapshot.data[index].name, style: TextStyle(color: Colors.blueAccent, fontSize: 20.0, fontWeight: FontWeight.bold),),
                      subtitle: 
                      Container(
                        
                        child:  Row(
                          //crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: <Widget>[
                           Icon(
                             Icons.phone,
                             color: Colors.grey,
                             size: 15,
                             ),
                           Text(snapshot.data[index].phone,),
                        ],

                      ),

                      ),
                     
                     
                      trailing: Icon(
                        Icons.offline_pin,
                        color: Colors.green,
                        size: 20,
                        ),

                        onTap: (){
                          Navigator.push(context, 
                          new MaterialPageRoute(
                            builder: (context) => DetailPage(snapshot.data[index]),

                          )
                          );
                        },

                    ),
                    
                    );
                 
                  },

                );
              }

            }
          )
        ),

      ),
    );
  }
}


class DetailPage extends StatelessWidget {
 // const DetailPage({Key key}) : super(key: key);

 User  user;

 DetailPage(this.user);

  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      home: Scaffold(

        appBar: AppBar(
          title: Text(user.name),
        ),

        body:Container(
     

          child: Card(
            
            
           child: Container(
             padding: EdgeInsets.all(20.0),
              child: Column(
            
              crossAxisAlignment: CrossAxisAlignment.stretch,
              
              children: <Widget>[
                Center(
                  child: Icon(
                    Icons.account_circle,
                    size:100.0,
                    color:Colors.grey
                  ),
                ),

                Center(

                  child:Text(user.name, style: TextStyle(fontSize: 30.0, color:Colors.lightBlue)),

                ),

                 Divider(),
                 

                Center(
                   child: Row(
                        children: <Widget>[
                          Icon(Icons.phone, 
                          color: Colors.grey,
                          size: 25.0,),
                        
                          Text(user.phone, style: TextStyle(fontSize: 25.0, color:Colors.grey)),

                        ],

                      ),
                ),

                 Divider(),

                Center(
                  child:     
                      Row(
                        children: <Widget>[
                          Icon(Icons.email, 
                          color: Colors.grey,
                          size: 25.0,),
                        
                          Text(user.email, style: TextStyle(fontSize: 25.0, color:Colors.grey)),

                        ],

                      ),

                ),

                Divider(),

                Center(
                  child:Row(
                        children: <Widget>[
                          Icon(Icons.map, 
                          color: Colors.grey,
                          size: 25.0,),
                        
                          Text(user.website, style: TextStyle(fontSize: 25.0, color:Colors.grey)),

                        ],

                      )
                       ,
                ),

            
                

              ],
           ),
            ),
          ),
        )
    ),

    );
    
  }
}

class User {
  final String name;
  final String email;
  final String phone;
  final String website;

  User(this.name, this.email, this.phone, this.website);
}


