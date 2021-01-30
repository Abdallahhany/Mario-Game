import 'dart:math';
import 'package:flutter/material.dart';

class MarioChar extends StatelessWidget {
  final direction;
  final midRun;
  final size;
  MarioChar({this.direction,this.midRun,this.size});

  @override
  Widget build(BuildContext context) {
    if(direction== "right"){
      return Container(
        width: size,
        height: size,
        child: midRun ? Image.asset('images/standing.png') :
        Image.asset('images/walking.png') ,
      );
    }else{
      return Transform(
        alignment: Alignment.center,
        transform: Matrix4.rotationY(pi),
        child: Container(
          width: size,
          height: size,
          child: midRun ? Image.asset('images/standing.png') :
          Image.asset('images/walking.png') ,
        ),
      );
    }
  }
}
