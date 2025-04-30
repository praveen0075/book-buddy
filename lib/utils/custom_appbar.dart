import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CustomAppBar extends StatelessWidget {
  Text titleText;
  Color backgroundColor;
  List<Widget>? actionWidget;
  CustomAppBar({
    super.key,
    required this.titleText,
    required this.backgroundColor,
   this.actionWidget
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      iconTheme: IconThemeData(color: Colors.white),
      title: titleText,
      backgroundColor: backgroundColor,
      actions: actionWidget
    );
  }
}
