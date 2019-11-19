import 'package:flutter/material.dart';
import 'package:poke_flutter/ui/home.dart';
import 'package:poke_flutter/ui/login/login.dart';
import 'package:provider/provider.dart';

void main() => runApp(MaterialApp(
  debugShowCheckedModeBanner: false,
  theme: ThemeData.light(),
  home: Login(),
));