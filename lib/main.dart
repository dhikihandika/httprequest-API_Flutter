//=============================================================================================================================================================================//
//========================================================================= Fetch JSON data HTTPRequest GET ===================================================================//
//=============================================================================================================================================================================//
//==================================================//
//==== created    : 25, September 2019          ====//
//==== programmer : dhikihandika                ====//
//==== email      : dhikihandika36@gmail.com    ====//
//==================================================//

import 'dart:convert';                                                                    // Include library Encoders and decoders for converting between different data representations, 
                                                                                          // including JSON and UTF-8.
import 'package:flutter/material.dart';                                                   // Include library to provide material design dart
import 'package:http/http.dart' as http;                                                                                // Include library to HTTP methode

void main() => runApp(new MaterialApp(                                                    // The runApp() function takes the given Widget and makes it the root of the widget tree.
  home: new HomePage(),                                                                   // HomePage Funcion its piece of widget tree
));

//==== HomePage Class
class HomePage extends StatefulWidget {                                                   // Allow to widget maintain state that might change during the lifetime
  @override                                                                               // Accestor to class
  HomePageState createState() => new HomePageState();                                     // Creates the mutable state (subclass) for this widget at a given location in the tree.
}

//----------------------------------------------- HomePageState Class
class HomePageState extends State<HomePage>{                                              // extends == subclass                                         

  final String url ="http://swapi.co/api/people";                                        // String URL API
  List data;                                                                              // Make a limit list its "data"

  @override
  void initState() { 
    super.initState();
    this.getJsonData();
  }
  
  Future<String> getJsonData() async {
    var response = await http.get(
      //Encode the url
      Uri.encodeFull(url),
      //only accept json response
      headers: {"Accept": "application/json"});           // define header its "application/json"

    print(response.body);                                 // print response get on command terminal

    setState(() {
      var convertDataToJson = jsonDecode(response.body);  // 'convertDataToJson' to 
       data = convertDataToJson['results'];
    });
    return "Success";
  }


  @override 
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("Retrieve JSON via HTTP Get"),                      // Widget lets you create a run of styled text within your application.
      ),
      body: new ListView.builder(
        itemCount: data == null ? 0 : data.length,
        itemBuilder: (BuildContext context, int index) {
        return new Container(
          child: new Center(
            child: new Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                new Card(
                  child: new Container(
                    child: new Text(data[index]['name']),
                    padding: const EdgeInsets.all(20.0)),
                )
              ],
            ),
          ),
        );
       },
      ),
    );
  }
}