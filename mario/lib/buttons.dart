import 'package:flutter/material.dart';

class ControlButtons extends StatelessWidget {
  final controlIcon;
  final function;
  static bool holdingButton = false;

  ControlButtons({this.controlIcon,this.function});

  bool userHoldingButton(){
    return holdingButton;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (details){
        holdingButton = true;
        function();
      },
      onTapUp:(details){
        holdingButton = false;
      },
      child: ClipRRect(
        borderRadius: BorderRadius.circular(15),
        child: Container(
          padding: EdgeInsets.all(10),
          color: Colors.brown[300],
          child:controlIcon,
        ),
      ),
    );
  }
}
