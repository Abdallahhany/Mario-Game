import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mario/buttons.dart';
import 'package:mario/jumping.dart';
import 'package:mario/mario_char.dart';
import 'mushroom.dart';

class MarioGame extends StatefulWidget {
  @override
  _MarioGameState createState() => _MarioGameState();
}

class _MarioGameState extends State<MarioGame> {
  static double marioX=0;
  static double marioY=1;
  double mushroomX=0.5;
  double mushroomY=1;
  double marioSize=35;
  double time = 0;
  double height = 0;
  double initialHeight = marioY;
  String direction = "right";
  bool midRun = false;
  bool midJump = false;
  var gameFont = GoogleFonts.pressStart2p(
    textStyle: TextStyle(color: Colors.white,fontSize: 20.0)
  );

  void checkIfAteMushroom(){
    if((marioX - mushroomX).abs() <0.05 && (marioY - mushroomY).abs() <0.05){
      setState(() {
        mushroomX = -0.5;
        marioSize = 60;
      });
    }
  }
  void preJump(){
    time = 0;
    initialHeight = marioY;
  }
  void jump(){
    if(midJump == false){
      midJump = true;
      preJump();
      Timer.periodic(Duration(milliseconds: 50), (timer) {
        time += 0.05;
        height = -4.9 * time * time + 5 * time;
        if(initialHeight - height > 1)  {
          midJump = false;
          setState(() {
            marioY = 1;
          });
          timer.cancel();
        }else{
          setState(() {
            marioY = initialHeight - height;
          });
        }
      });
    }
  }
  void moveRight(){
    direction = "right";
    checkIfAteMushroom();
    Timer.periodic(Duration(milliseconds: 50), (timer) {
      if(ControlButtons().userHoldingButton()==true&&marioX +0.02 <1){
        setState(() {
          marioX +=0.02;
          midRun = !midRun;
        });
      }else{
        timer.cancel();
      }
    });
  }
  void moveLeft(){
    direction = "left";
    checkIfAteMushroom();
    Timer.periodic(Duration(milliseconds: 50), (timer) {
      if(ControlButtons().userHoldingButton()==true&&marioX -0.02 >-1){
        setState(() {
          marioX -= 0.02;
          midRun = !midRun;
        });
      }else{
        timer.cancel();
      }
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:Column(
        children: [
          Expanded(
            flex: 4,
              child:Stack(
                children: [
                  Container(
                    color: Colors.blue,
                    child: AnimatedContainer(
                      alignment: Alignment(marioX,marioY),
                      duration: Duration(milliseconds: 0),
                      child: midJump ?
                      Jumping(direction: direction,size: marioSize,) :
                      MarioChar(direction: direction,midRun: midRun,size: marioSize,),
                    ),
                  ),
                  Container(
                    alignment: Alignment(mushroomX,mushroomY),
                      child: Mushroom()
                  ),
                  SafeArea(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Column(
                          children: [
                            Text('MARIO',style: gameFont,),
                            SizedBox(height: 10,),
                            Text('0000',style: gameFont,)
                          ],
                        ),
                        Column(
                          children: [
                            Text('World',style: gameFont,),
                            SizedBox(height: 10,),
                            Text('1-1',style: gameFont,)
                          ],
                        ),
                        Column(
                          children: [
                            Text('Time',style: gameFont,),
                            SizedBox(height: 10,),
                            Text('9999',style: gameFont,)
                          ],
                        )
                      ],
                    ),
                  )
                ],
              )
          ),
          Expanded(
              flex: 1,
              child: Container(
                color: Colors.brown,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ControlButtons(
                      function: moveLeft,
                      controlIcon:
                      Icon(
                        Icons.arrow_back,color: Colors.white,
                      ),
                    ),
                    ControlButtons(
                      controlIcon:
                      Icon(
                        Icons.arrow_upward,color: Colors.white,
                      ),
                      function:jump ,
                    ),
                    ControlButtons(
                      function: moveRight,
                      controlIcon:
                      Icon(
                        Icons.arrow_forward,color: Colors.white,
                      ),
                    ),
                  ],
                ),
              )
          ),
        ],
      ) ,
    );
  }
}
