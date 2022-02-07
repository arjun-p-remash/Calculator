import 'package:flutter/material.dart';

class Button extends StatelessWidget {
  final color;
  final textColor;
  final String buttonText;
  final buttonTapped;

  /*const Buttons({Key? key}) : super(key: key);*/
  Button({this.color,this.textColor,required this.buttonText,this.buttonTapped});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: buttonTapped,
      child: Padding(
        padding: const EdgeInsets.all(5.0),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(25),
            child: Container(

              color: color,
              child: Center(child: Text(buttonText,style: TextStyle(color: textColor,fontSize: 20,fontWeight: FontWeight.bold),)),
            )
        ),
      ),
    );
  }
}
