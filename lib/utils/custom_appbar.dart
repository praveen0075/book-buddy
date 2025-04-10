import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget {
  Text titleText;
  Color backgroundColor;
  CustomAppBar({
    super.key,
    required this.titleText,
    required this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      iconTheme: IconThemeData(color: Colors.white),
      title: titleText,
      backgroundColor: backgroundColor,
    );
  }
}
