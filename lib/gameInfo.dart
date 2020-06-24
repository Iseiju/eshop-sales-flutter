import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:switch_sales/models/game.dart';

class GameInfo extends StatelessWidget {
  final Game game;

  GameInfo({Key key, @required this.game}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: CupertinoNavigationBar(
          leading: CupertinoNavigationBarBackButton(
              color: Colors.orange,
              onPressed: () => Navigator.of(context).pop()),
          middle: Text(
            "Game Info",
            style: TextStyle(
              color: Colors.orange,
              fontSize: 20,
              fontFamily: 'GoogleSans',
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.only(top: 8, bottom: 8, left: 8, right: 8),
              child: Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8)),
                  elevation: 4,
                  child: Row(
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.only(
                            top: 8, bottom: 8, left: 8, right: 8),
                        child: Image(
                          image: AssetImage('assets/images/placeholder.png'),
                          width: 70,
                          height: 70,
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            game.title,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                                fontSize: 16,
                                fontFamily: 'GoogleSans',
                                fontWeight: FontWeight.bold,
                                color: Color.fromARGB(255, 37, 118, 188)),
                          ),
                          Wrap(
                            spacing: 4,
                            children: <Widget>[
                              Text(
                                "\$${game.salePrice.toString()}",
                                style: TextStyle(
                                    fontSize: 16,
                                    fontFamily: 'GoogleSans',
                                    fontWeight: FontWeight.bold,
                                    color: Colors.orange),
                              ),
                              Text("\$${game.price.toString()}",
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontFamily: 'GoogleSans',
                                      color: Color.fromARGB(255, 67, 67, 67),
                                      decoration: TextDecoration.lineThrough))
                            ],
                          )
                        ],
                      )
                    ],
                  )),
            ),
          ),
        ));
  }
}
