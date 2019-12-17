import 'package:flutter/material.dart';
import 'package:poke_flutter/bloc/login_bloc/login_bloc.dart';
import 'package:poke_flutter/ui/home.dart';
import 'package:poke_flutter/ui/login/login.dart';

void main() => runApp(MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.light(),
      home: HomeController(),
));

class HomeController extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<String>(
      stream: loginBLoc.onAuthStateChanged,
      builder: (context, snapshot){
        return snapshot.hasData ? Home() : Login();
      },
    );
  }
}