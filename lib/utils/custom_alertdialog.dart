import 'package:flutter/material.dart';

class CustomAlertDialog extends StatelessWidget {
  Widget titleWidget;
  Widget leadingWidget1;
  Widget leadingWidget2;
  Widget listTitle1;
  Widget listTilte2;
  void Function()? onTap1;
  void Function()? onTap2;
  CustomAlertDialog({
    super.key,
    required this.titleWidget,
    required this.leadingWidget1,
    required this.leadingWidget2,
    required this.listTitle1,
    required this.listTilte2,
    this.onTap1,
    this.onTap2
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: titleWidget,
      actions: [
        ListTile(leading: leadingWidget1, title: listTitle1, onTap: onTap1),
        ListTile(leading: leadingWidget2, title: listTilte2, onTap: onTap2),
      ],
      // actions: [
      //   ListTile(leading: Icon(Icons.edit),title: Text("Edit"),),
      //   ListTile(leading: Icon(Icons.delete),title: Text("Delete"),),
      // ],
    );
  }
}
