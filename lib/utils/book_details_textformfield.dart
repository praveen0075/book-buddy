import 'package:flutter/material.dart';

class BookDetailsTextFormField extends StatelessWidget {
  int? maxLine;
  double? height;
  String? initValue;
  void Function(String?)? onSaved;
  String? Function(String?)? validator;
  TextInputType? keyBoardType;
  // TextEditingController? controller;
  BookDetailsTextFormField({super.key, this.maxLine,this.height,this.initValue,this.onSaved,this.validator,this.keyBoardType});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height ?? 55,
      child: TextFormField(
        keyboardType: keyBoardType,
        // controller: controller,
        initialValue: initValue,
        maxLines: maxLine,
        decoration: InputDecoration(
          errorBorder: OutlineInputBorder(),
          // errorStyle:,
          // hintText: "Title",
          border: OutlineInputBorder(borderSide: BorderSide.none),
          filled: true,
          fillColor: Colors.white,
        ),
        validator: validator,
        onSaved: onSaved,
      ),
    );
  }
}
