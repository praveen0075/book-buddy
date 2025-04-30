import 'dart:developer';

import 'package:book_buddy/const.dart';
import 'package:book_buddy/models/book_model.dart';
import 'package:book_buddy/provider/book_services.dart';
import 'package:book_buddy/utils/book_details_textformfield.dart';
import 'package:book_buddy/utils/custom_appbar.dart';
import 'package:book_buddy/utils/custom_buttton1.dart';
import 'package:choice/choice.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BookDetailsPage extends StatefulWidget {
  BookModel bookModel;
  int bookIndexNumber;
  BookDetailsPage({
    super.key,
    required this.bookModel,
    required this.bookIndexNumber,
  });

  @override
  State<BookDetailsPage> createState() => _BookDetailsPageState();
}

class _BookDetailsPageState extends State<BookDetailsPage> {
  String newbookTile = "";
  String newbookAuthor = "";
  String newbookDesc = "";
  String newBooknumberOfPageRead = "0";
  String? finalSelectedValue;
  final _formKey = GlobalKey<FormState>();
  List statusChoice = ["Want To Read", "Ongoing", "Completed"];
  String? selectedValue;
  @override
  void initState() {
    super.initState();
    if (widget.bookModel.bookStatus == "Ongoing") {
      selectedValue = statusChoice[1];
    } else if (widget.bookModel.bookStatus == "Want To Read") {
      selectedValue = statusChoice[0];
    } else {
      selectedValue = statusChoice[2];
    }
    // selectedValue = widget.bookModel.bookStatus;
    log("selected values is = $selectedValue");
  }

  void onSubmit(BookServicves bookServices) {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      try {
        if (int.parse(newBooknumberOfPageRead) >
            widget.bookModel.totalNumberOfPages) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                "Number of pages you have read is greater than the total number of pages",
              ),
            ),
          );
        } else {
          log(newBooknumberOfPageRead);
          log(widget.bookModel.totalNumberOfPages.toString());
          log(widget.bookModel.bookStatus);
          final bookModel = BookModel(
            id: widget.bookModel.id,
            title: newbookTile,
            authorName: newbookAuthor,
            totalNumberOfPages: widget.bookModel.totalNumberOfPages,
            pagesRead:
                selectedValue == "Completed"
                    ? widget.bookModel.totalNumberOfPages
                    : int.parse(newBooknumberOfPageRead),
            bookStatus:
                int.parse(newBooknumberOfPageRead) ==
                        widget.bookModel.totalNumberOfPages
                    ? "Completed"
                    : selectedValue!,
            imageUrl: widget.bookModel.imageUrl,
            favorite: widget.bookModel.favorite,
          );
          try {
            bookServices.updateBook(bookModel);
            Navigator.pop(context);
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text("Successfully updated")));
          } catch (e) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text("Something went wrong")));
          }
        }
      } catch (e) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text("Enterd value is not a number")));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    var mQuery = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: appScaffoldBackgroundColor,
      appBar: PreferredSize(
        preferredSize: Size(mQuery.width, mQuery.height / 14),
        child: CustomAppBar(
          actionWidget: [
            Consumer<BookServicves>(
              builder: (context, value, child) {
                final currentBook = value.books.firstWhere(
                  (book) => book.id == widget.bookModel.id,
                  orElse: () => widget.bookModel,
                );
                return IconButton(
                  onPressed: () {
                    log(widget.bookModel.favorite.toString());
                    value.changeIsFavorite(currentBook);
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          currentBook.favorite
                              ? "Removed from favorites"
                              : "Added to favorites",
                        ),
                        duration: Duration(seconds: 1),
                      ),
                    );
                  },
                  icon: Icon(
                    Icons.favorite,
                    color: currentBook.favorite ? Colors.red : Colors.white,
                  ),
                );
              },
            ),
          ],
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
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Book Title",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    BookDetailsTextFormField(
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Please enter the title";
                        }
                        return null;
                      },
                      initValue: widget.bookModel.title,
                      onSaved: (value) {
                        newbookTile = value!;
                      },
                    ),
                    kh10,
                    Text(
                      "Author of the Book",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    BookDetailsTextFormField(
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Please enter the author name";
                        }
                        return null;
                      },
                      initValue: widget.bookModel.authorName,
                      onSaved: (value) {
                        newbookAuthor = value!;
                      },
                    ),
                    kh10,
                    Text(
                      "Description ",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    BookDetailsTextFormField(
                      maxLine: 300,
                      height: 100,
                      initValue: widget.bookModel.description,
                      onSaved: (value) {
                        newbookDesc = value!;
                      },
                    ),
                    kh10,
                    Text(
                      "Number of Pages you have read",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    BookDetailsTextFormField(
                      keyBoardType: TextInputType.number,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Please enter the number of pages you read";
                        }
                        return null;
                      },
                      initValue: widget.bookModel.pagesRead.toString(),
                      onSaved: (value) {
                        newBooknumberOfPageRead = value!;
                      },
                    ),
                    kh10,
                    Text(
                      "Select your reading status",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    kh10,
                    InlineChoice.single(
                      value: selectedValue,
                      onChanged: (value) {
                        setState(() {
                          selectedValue = value;
                        });
                      },
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
                  child: Consumer<BookServicves>(
                    builder: (context, value, child) {
                      return GestureDetector(
                        onTap: () {
                          onSubmit(value);
                        },
                        child: CustomButtton1(
                          btnTxt: "Submit",
                          color: appBaseClr,
                          txtStyle: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
