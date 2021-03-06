import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter_image/network.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:switch_sales/gameInfo.dart';
import 'package:switch_sales/models/dataEnvelope.dart';
import 'package:switch_sales/models/game.dart';

void main() => runApp(MainApp());

class MainApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _MyAppState();
}

class _MyAppState extends State<MainApp> {
  final String url = 'http://switchsales.herokuapp.com/games/eshop-sales';
  List<Game> gameList = [];

  Future<Null> _fetchGames() async {
    var response = await http.get(url);

    if (response.statusCode == 200) {
      final jsonResponse = json.decode(response.body);

      var games = DataEnvelope.fromJson(jsonResponse);
      games.data.sort((a, b) => a.title.compareTo(b.title));

      setState(() {
        gameList.clear();
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
      body: RefreshIndicator(
          child: ListView.builder(
            itemCount: gameList.length,
            itemBuilder: (context, index) {
              return InkWell(
                child: Card(
                    elevation: 0,
                    borderOnForeground: false,
                    color: Colors.transparent,
                    child: Padding(
                      padding:
                          EdgeInsets.only(top: 4, bottom: 4, left: 4, right: 4),
                      child: Row(
                        children: <Widget>[
                          FadeInImage(
                            fadeInDuration: Duration(milliseconds: 1),
                            image:
                                NetworkImageWithRetry(gameList[index].boxArt),
                            placeholder:
                                Image.asset("assets/images/placeholder.png")
                                    .image,
                            width: 70,
                            height: 70,
                          ),
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
                                        color:
                                            Color.fromARGB(255, 37, 118, 188))),
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
                    )),
                onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => GameInfo(
                              game: gameList[index],
                            ))),
              );
            },
          ),
          onRefresh: _fetchGames),
    ));
  }
}
