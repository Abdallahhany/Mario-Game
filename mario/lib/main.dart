import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'mario_game.dart';

void main() {
  runApp(MyApp());
  SystemChrome.setPreferredOrientations([DeviceOrientation.landscapeLeft]);
}


class MyApp extends StatelessWidget{
  @override
  Widget build(BuildContext context){
    return MaterialApp(

      debugShowCheckedModeBanner: false,
      home: MarioGame(),
    );
  }
}
