import 'package:flutter/material.dart';

class AddNewBookTextFormField extends StatelessWidget {
  // String bookTitle;
  String? Function(String?)? validator;
  void Function(String?)? onSaved;
  int? maxline;
  int? minline;
  double? height;
  TextInputType? txtInputType;
  AddNewBookTextFormField({
    super.key,
    required this.validator,
    required this.onSaved,
    this.height,
    this.maxline,
    this.txtInputType,
    this.minline,
    // required this.bookTitle
  });

  @override
  Widget build(BuildContext context) {

    return TextFormField(
      autovalidateMode: AutovalidateMode.onUserInteraction,
      minLines: minline,
      keyboardType: txtInputType,
      maxLines: maxline,
      decoration: InputDecoration(
        errorBorder: OutlineInputBorder(),
    
        // errorStyle:TextStyle(height: 0.8),
        // hintText: "Title",
        border: OutlineInputBorder(borderSide: BorderSide.none),
        filled: true,
        fillColor: Colors.white,
      ),
      validator: validator,
      onSaved: onSaved,
    );
  }
}
