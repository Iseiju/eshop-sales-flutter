import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:switch_sales/models/dataEnvelope.dart';
import 'package:switch_sales/models/game.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final String url = 'http://switchsales.herokuapp.com/games/eshop-sales';
  List<Game> gameList = [];

  Future<Null> _fetchGames() async {
    gameList = [];
    var response = await http.get(url);

    if (response.statusCode == 200) {
      final jsonResponse = json.decode(response.body);

      var games = new DataEnvelope.fromJson(jsonResponse);
      games.data.sort((a, b) => a.title.compareTo(b.title));

      setState(() {
        gameList.addAll(games.data);
      });
    } else {
      throw Exception('Something went wrong');
    }
  }

  initState() {
    super.initState();
    _fetchGames();
  }

  dispose() {
    super.dispose();
  }

  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
      backgroundColor: Colors.white,
      appBar: CupertinoNavigationBar(
        middle: Text(
          "Sales",
          style: TextStyle(
            color: Colors.orange,
            fontSize: 20,
            fontFamily: 'GoogleSans',
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.white,
      ),
      body: new RefreshIndicator(
          child: ListView.builder(
            itemCount: gameList.length,
            itemBuilder: (context, index) {
              return Padding(
                  padding:
                      EdgeInsets.only(top: 4, bottom: 4, left: 4, right: 4),
                  child: Card(
                      elevation: 0,
                      borderOnForeground: false,
                      child: Padding(
                        padding: EdgeInsets.only(
                            top: 4, bottom: 4, left: 4, right: 4),
                        child: Row(
                          children: <Widget>[
                            new FadeInImage.assetNetwork(
                                image: gameList[index].boxArt,
                                placeholder: 'assets/images/placeholder.png',
                                width: 70,
                                height: 70),
                            Flexible(
                                child: Padding(
                              padding: EdgeInsets.only(left: 8, right: 8),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text(gameList[index].title,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontFamily: 'GoogleSans',
                                          fontWeight: FontWeight.bold,
                                          color: Color.fromARGB(
                                              255, 37, 118, 188))),
                                  Text(
                                    "\$${gameList[index].price.toString()}",
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontFamily: 'GoogleSans',
                                        color: Color.fromARGB(255, 67, 67, 67),
                                        decoration: TextDecoration.lineThrough),
                                  ),
                                  Text(
                                    "\$${gameList[index].salePrice.toString()}",
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontFamily: 'GoogleSans',
                                        color: Colors.orange),
                                  ),
                                ],
                              ),
                            ))
                          ],
                        ),
                      )));
            },
          ),
          onRefresh: _fetchGames),
    ));
  }
}
