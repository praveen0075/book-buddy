import 'dart:developer';

import 'package:flutter/material.dart';

class CustomButtton1 extends StatelessWidget {
  TextStyle? txtStyle;
  Color? color;
  String btnTxt;
  double ? buttonWidth;
  CustomButtton1({super.key, this.txtStyle, this.color, required this.btnTxt,this.buttonWidth});

  @override
  Widget build(BuildContext context) {
    log(buttonWidth.toString());
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 30),
      height: 55,
      width: buttonWidth,
      decoration: BoxDecoration(
        // color: Color.fromARGB(162, 163, 22, 163),
        color: color,
        borderRadius: BorderRadius.circular(35),
      ),
      child: Center(child: Text(btnTxt, style: txtStyle)),
    );
  }
}
