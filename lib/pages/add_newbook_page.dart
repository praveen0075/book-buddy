import 'dart:developer';

import 'package:book_buddy/const.dart';
import 'package:book_buddy/models/book_model.dart';
import 'package:book_buddy/provider/book_services.dart';
import 'package:book_buddy/provider/cover_image_selection.dart';
import 'package:book_buddy/utils/addnewbook_textformfield.dart';
import 'package:book_buddy/utils/custom_appbar.dart';
import 'package:book_buddy/utils/custom_buttton1.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

String bookTitle = "";
String autherName = "";
String description = "";
String imageURl = "";
int totalPages = 0;

class AddNewbookPage extends StatefulWidget {
  const AddNewbookPage({super.key});

  @override
  State<AddNewbookPage> createState() => _AddNewbookPageState();
}

class _AddNewbookPageState extends State<AddNewbookPage> {
  TextEditingController titleController = TextEditingController();
  TextEditingController authorController = TextEditingController();
  TextEditingController totalPageNumberController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  void onButtonPressed(BookServicves bookServices) {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      if (imageURl == "") {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Cover Page is not Selected"),
            duration: Duration(seconds: 2),
          ),
        );
      } else {
        int timeStamp = DateTime.now().millisecondsSinceEpoch;
        log("Book title is $bookTitle");
        log("Book author is $autherName");
        log("Book descritpion is $description");

        final bookModel = BookModel(
          id: timeStamp.toString(),
          title: bookTitle,
          authorName: autherName,
          totalNumberOfPages: totalPages,
          pagesRead: 0,
          description: description,
          bookStatus: "Ongoing",
          imageUrl: imageURl,
          favorite: false
        );
        try {
          bookServices.addBook(bookModel);
          titleController.clear();
          authorController.clear();
          totalPageNumberController.clear();
          descriptionController.clear();
          Navigator.pop(context);
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text("Successfully added the book"),
              duration: Duration(seconds: 2),
            ),
          );
        } catch (e) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text("Failed to add the book"),
              duration: Duration(seconds: 2),
            ),
          );
        }
      }
    }
  }

  void collectImageUrl(CoverImageSelection model) {
    String? selectedImageURLTemp = model.getSelectedImageUrl();
    if (selectedImageURLTemp == null) {
      log("selectedImageURlTemp is null");
    } else {
      imageURl = selectedImageURLTemp;
      log("imageURl is $imageURl");
    }
  }

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    var mQuery = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 236, 225, 237),
      appBar: PreferredSize(
        preferredSize: Size(mQuery.width, mQuery.height / 16),
        child: CustomAppBar(
          titleText: Text(
            "Add Book",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          backgroundColor: appBaseClr,
        ),
      ),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Book Title",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                AddNewBookTextFormField(
                  controller: titleController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Please enter the title";
                    }
                    return null;
                  },
                  onSaved: (newValue) {
                    bookTitle = newValue!;
                  },
                ),
                kh10,
                Text(
                  "Author of the book",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                AddNewBookTextFormField(
                  controller: authorController,
                  // maxline: 80,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Please enter the Author name";
                    }
                    return null;
                  },
                  onSaved: (newValue) {
                    autherName = newValue!;
                  },
                ),
                kh10,
                Text(
                  "Total number of pages",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                AddNewBookTextFormField(
                  controller: totalPageNumberController,
                  txtInputType: TextInputType.number,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Please enter total number of pages";
                    } else {
                      return null;
                    }
                  },
                  onSaved: (newValue) {
                    int number = int.parse(newValue!);
                    totalPages = number;
                  },
                ),
                kh10,
                Text(
                  "Description (Optional)",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                AddNewBookTextFormField(
                  controller: descriptionController,
                  minline: 4,
                  maxline: 250,
                  height: 200,
                  validator: (value) {
                    // if (value == null || value.isEmpty) {
                    //   return "Please enter the description";
                    // }
                    // return null;
                  },
                  onSaved: (newValue) {
                    description = newValue!;
                  },
                ),
                kh10,
                Text(
                  "Select a coverpage for your book",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                kh10,
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: SizedBox(
                    height: 250,
                    width: mQuery.width,
                    child: Consumer<CoverImageSelection>(
                      builder: (context, model, child) {
                        return GridView(
                          physics: NeverScrollableScrollPhysics(),
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 3,
                                mainAxisSpacing: 10,
                                childAspectRatio: 1.1,
                                crossAxisSpacing: 5,
                              ),
                          children: List.generate(model.coverPageUrl.length, (
                            index,
                          ) {
                            return GestureDetector(
                              onTap: () {
                                model.selectItem(index);
                                collectImageUrl(model);
                              },
                              child: Container(
                                padding: EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                  color: const Color.fromARGB(47, 110, 18, 118),
                                  border: Border.all(),
                                  borderRadius: BorderRadius.circular(12),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Theme.of(
                                        context,
                                      ).primaryColor.withAlpha(2),
                                      blurRadius: 10,
                                      spreadRadius: 2,
                                    ),
                                  ],
                                ),
                                height: 80,
                                child: Stack(
                                  alignment: Alignment.center,
                                  children: [
                                    Image.asset(
                                      model.coverPageUrl[index],
                                      fit: BoxFit.fitHeight,
                                    ),
                                    if (model.selectedIndex == index)
                                      Positioned(
                                        right: 0,
                                        top: 0,
                                        child: Container(
                                          padding: EdgeInsets.all(4),
                                          decoration: BoxDecoration(
                                            color:
                                                Theme.of(context).primaryColor,
                                            shape: BoxShape.circle,
                                          ),
                                          child: Icon(
                                            Icons.check,
                                            color: Colors.white,
                                            size: 14,
                                          ),
                                        ),
                                      ),
                                  ],
                                ),
                              ),
                            );
                          }),
                        );
                      },
                    ),
                  ),
                ),
                // kh20,
                // kh20,
                Consumer<BookServicves>(
                  builder: (context, bookServicves, child) {
                    return GestureDetector(
                      onTap: () {
                        onButtonPressed(bookServicves);
                      },
                      child: CustomButtton1(
                        btnTxt: "Submit",
                        color: appBaseClr,
                        txtStyle: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                        buttonWidth: mQuery.width,
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
