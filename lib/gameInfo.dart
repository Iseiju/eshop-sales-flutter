import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class GameInfo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      backgroundColor: Colors.white,
      navigationBar: CupertinoNavigationBar(
        leading: CupertinoNavigationBarBackButton(
            color: Colors.orange, onPressed: () => Navigator.of(context).pop()),
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
      child: SingleChildScrollView(
        child: Card(
          elevation: 8,
          color: Colors.black,
          child: Padding(
            padding: EdgeInsets.only(top: 4, bottom: 4, left: 4, right: 4),
            child: Image(
              image: AssetImage('assets/images/placeholder.png'),
              width: 70,
              height: 70,
            ),
          ),
        ),
      ),
    );
  }
}
