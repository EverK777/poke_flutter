import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Teams extends StatelessWidget{
  const Teams({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _screenSize = MediaQuery.of(context).size;
    return Container(
      height:_screenSize.height - (_screenSize.height * 0.30 -
          (MediaQuery.of(context).padding.top))-75.0,
      width: double.infinity,
      color: Colors.white,
      child: Column(
        children: <Widget>[
          Text('Teams')
        ],
      ),
    );
  }
}