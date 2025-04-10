import 'package:flutter/material.dart';

class BookDetailsTextFormField extends StatelessWidget {
  int? maxLine;
  double? height;
  BookDetailsTextFormField({super.key, this.maxLine,this.height});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height ?? 55,
      child: TextFormField(
        maxLines: maxLine,
        decoration: InputDecoration(
          errorBorder: OutlineInputBorder(),
          // errorStyle:,
          // hintText: "Title",
          border: OutlineInputBorder(borderSide: BorderSide.none),
          filled: true,
          fillColor: Colors.white,
        ),
        validator: (value) {},
        onSaved: (newValue) {},
      ),
    );
  }
}
