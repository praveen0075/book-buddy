import 'package:flutter/material.dart';

class AddNewBookTextFormField extends StatelessWidget {
  String? Function(String?)? validator;
  void Function(String?)? onSaved;
  int? maxline;
  int? minline;
  double? height;
  TextInputType? txtInputType;
  TextEditingController? controller;
  AddNewBookTextFormField({
    super.key,
    this.validator,
    required this.onSaved,
    this.height,
    this.maxline,
    this.txtInputType,
    this.minline,
    this.controller
  });

  @override
  Widget build(BuildContext context) {

    return TextFormField(
      controller: controller,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      minLines: minline,
      keyboardType: txtInputType,
      maxLines: maxline,
      decoration: InputDecoration(
        errorBorder: OutlineInputBorder(),
        border: OutlineInputBorder(borderSide: BorderSide.none),
        filled: true,
        fillColor: Colors.white,
      ),
      validator: validator,
      onSaved: onSaved,
    );
  }
}
