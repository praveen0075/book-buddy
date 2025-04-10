import 'package:book_buddy/const.dart';
import 'package:book_buddy/utils/book_details_textformfield.dart';
import 'package:book_buddy/utils/custom_appbar.dart';
import 'package:book_buddy/utils/custom_buttton1.dart';
import 'package:choice/choice.dart';
import 'package:flutter/material.dart';

class BookDetailsPage extends StatefulWidget {
  const BookDetailsPage({super.key});

  @override
  State<BookDetailsPage> createState() => _BookDetailsPageState();
}

class _BookDetailsPageState extends State<BookDetailsPage> {
  final _formKey = GlobalKey<FormState>();
  List statusChoice = ["Want To Read", "Ongoing", "Completed"];
  String? selectedValue;
  @override
  Widget build(BuildContext context) {
    var mQuery = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: appScaffoldBackgroundColor,
      appBar: PreferredSize(
        preferredSize: Size(mQuery.width, mQuery.height / 14),
        child: CustomAppBar(
          titleText: Text(
            "Book Details",
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
          backgroundColor: appBaseClr,
        ),
      ),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Book Title",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                  BookDetailsTextFormField(),
                  kh10,
                  Text(
                    "Author of the Book",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                  BookDetailsTextFormField(),
                  kh10,
                  Text(
                    "Description ",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                  BookDetailsTextFormField(maxLine: 300, height: 100),
                  kh10,
                  Text(
                    "Number of Pages you have read",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                  BookDetailsTextFormField(),
                  kh10,
                  Text(
                    "Select your reading status",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                  kh10,
                  InlineChoice.single(
                    // value: selectedValue,
                    // onChanged: ,
                    itemCount: statusChoice.length,
                    itemBuilder:
                        (state, index) => ChoiceChip(
                          label: Text(statusChoice[index]),
                          selected: state.selected(statusChoice[index]),
                          onSelected: state.onSelected(statusChoice[index]),
                        ),
                    listBuilder: ChoiceList.createScrollable(
                      spacing: 10,
                      runSpacing: 10,
                      padding: EdgeInsets.symmetric(),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 20),
                child: CustomButtton1(
                  btnTxt: "Submit",
                  color: appBaseClr,
                  txtStyle: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
