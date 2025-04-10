import 'package:flutter/material.dart';

class CustomDeleteAlertBox extends StatelessWidget {
  void Function()? onTap1;
  void Function()? onTap2;
  CustomDeleteAlertBox({super.key, this.onTap1, this.onTap2});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text("Are you sure?"),
      actions: [
        GestureDetector(
          onTap: onTap1,
          child: Text(
            "Delete",
            style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
          ),
        ),
        GestureDetector(
          onTap: onTap2,
          child: Text("Cancel", style: TextStyle(fontWeight: FontWeight.bold)),
        ),
      ],
    );
  }
}
