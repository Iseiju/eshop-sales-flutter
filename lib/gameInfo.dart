import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:switch_sales/models/game.dart';
import 'package:url_launcher/url_launcher.dart';

class GameInfo extends StatelessWidget {
  final Game game;

  GameInfo({Key key, @required this.game}) : super(key: key);

  _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not open $url';
    }
  }

  String _setReleaseDate() {
    DateFormat dateFormat = DateFormat("yyyy-MM-dd");
    return dateFormat.parse(game.releaseDate.split('T')[0]).toString();
  }

  String _setRating() {
    if (game.esrb == "Everyone") {
      return 'assets/images/ic_everyone.png';
    } else if (game.esrb == "Teen") {
      return 'assets/images/ic_teen.png';
    } else if (game.esrb == "Mature") {
      return 'assets/images/ic_mature17plus.png';
    } else if (game.esrb == "Everyone 10+") {
      return 'assets/images/ic_everyone10plus.png';
    } else if (game.esrb == "Adults Only") {
      return 'assets/images/ic_adultsonly.png';
    } else if (game.esrb == "Early Childhood") {
      return 'assets/images/ic_earlychildhood.png';
    } else {
      return 'assets/images/ic_ratingpending.png';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: CupertinoNavigationBar(
          leading: CupertinoNavigationBarBackButton(
              color: Colors.orange,
              onPressed: () => Navigator.of(context).pop()),
          middle: Text(
            "Info",
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
              child: Column(
                children: <Widget>[
                  Card(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8)),
                      elevation: 4,
                      child: Row(
                        children: <Widget>[
                          Padding(
                            padding: EdgeInsets.only(
                                top: 8, bottom: 8, left: 8, right: 8),
                            child: FadeInImage.assetNetwork(
                              image: game.boxArt,
                              placeholder: 'assets/images/placeholder.png',
                              width: 90,
                              height: 90,
                            ),
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                game.title,
                                // maxLines: 2,
                                // overflow: TextOverflow.ellipsis,
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
                                          color:
                                              Color.fromARGB(255, 67, 67, 67),
                                          decoration:
                                              TextDecoration.lineThrough))
                                ],
                              )
                            ],
                          )
                        ],
                      )),
                  Padding(
                    padding:
                        EdgeInsets.only(top: 4, bottom: 4, left: 4, right: 4),
                    child: SizedBox(
                        width: double.infinity,
                        child: RaisedButton(
                            color: Color.fromARGB(255, 37, 118, 188),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8)),
                            child: Text(
                              "Go to eShop",
                              style: TextStyle(
                                  fontSize: 16,
                                  fontFamily: 'GoogleSans',
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                            ),
                            onPressed: () => _launchURL(game.url))),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 8, right: 8),
                    child: Text(
                      game.description,
                      style: TextStyle(fontSize: 16, fontFamily: 'GoogleSans'),
                    ),
                  ),
                  Padding(
                    padding:
                        EdgeInsets.only(top: 12, bottom: 12, left: 4, right: 4),
                    child: Container(
                      width: double.infinity,
                      height: 1,
                      color: Colors.black,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 8, right: 8, bottom: 8),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              "Release Date: ${_setReleaseDate()}",
                              style: TextStyle(
                                  fontSize: 16, fontFamily: 'GoogleSans'),
                            ),
                            Text("Category: ${game.categories}",
                                style: TextStyle(
                                    fontSize: 16, fontFamily: 'GoogleSans')),
                            Text("Company: ${game.company}",
                                style: TextStyle(
                                    fontSize: 16, fontFamily: 'GoogleSans'))
                          ],
                        ),
                        Image.asset(
                          _setRating(),
                          height: 80,
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ));
  }
}
