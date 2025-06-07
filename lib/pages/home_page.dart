import 'dart:developer';

import 'package:book_buddy/const.dart';
import 'package:book_buddy/models/book_model.dart';
import 'package:book_buddy/pages/add_newbook_page.dart';
import 'package:book_buddy/pages/book_details_page.dart';
import 'package:book_buddy/provider/book_services.dart';
import 'package:book_buddy/styles/home_page_sytles.dart';
import 'package:book_buddy/utils/custom_alertdialog.dart';
import 'package:book_buddy/utils/custom_appbar.dart';
import 'package:book_buddy/utils/custom_delete_alertbox.dart';
import 'package:book_buddy/widgets/homepage_book_card_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<BookModel> allBooks = [];
  void onTap2FunctionOfOnLongPress(
    BuildContext context,
    BookServicves value,
    BookModel bookValue,
  ) {
    Navigator.pop(context);
    showDialog(
      context: context,
      builder: (context) {
        return CustomDeleteAlertBox(
          onTap1: () {
            try {
              value.deleteBook(bookValue.id);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text("${bookValue.title} is deleted")),
              );
              Navigator.pop(context);
            } catch (e) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text("Failed to delete ${bookValue.title}")),
              );
              Navigator.pop(context);
            }
          },
          onTap2: () => Navigator.pop(context),
        );
      },
    );
  }

  void onLongPressOnTile(
    BuildContext context,
    BookServicves value,
    BookModel bookValue,
  ) {
    showDialog(
      context: context,
      builder: (context) {
        return CustomAlertDialog(
          leadingWidget1: Icon(Icons.edit),
          leadingWidget2: Icon(Icons.delete, color: Colors.red),
          titleWidget: Text("Options"),
          listTitle1: Text("Edit"),
          listTilte2: Text("Delete", style: TextStyle(color: Colors.red)),
          onTap1: () {},
          onTap2: () {
            onTap2FunctionOfOnLongPress(context, value, bookValue);
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    var mQuery = MediaQuery.of(context).size;
    return Scaffold(
      floatingActionButton: SizedBox(
        width: 110,
        child: FloatingActionButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => AddNewbookPage()),
            );
          },
          backgroundColor: const Color.fromARGB(255, 156, 103, 161),
          child: Row(
            children: [
              kw5,
              Icon(Icons.add, color: Colors.white),
              kw5,
              Text("New Book", style: TextStyle(color: Colors.white)),
            ],
          ),
        ),
      ),
      appBar: PreferredSize(
        preferredSize: Size(mQuery.width, mQuery.height / 14),
        child: CustomAppBar(
          titleText: Text("BOOK BUDDY", style: homePageAppBartitleTextStyle),
          backgroundColor: appBaseClr,
        ),
      ),
      body: Consumer<BookServicves>(
        builder: (context, value, child) {
          allBooks =
              value.books
                  .where((element) => element.bookStatus != "Completed")
                  .toList();
          log(allBooks.toString());
          return allBooks.isEmpty
              ? Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset("assets/images/no-data.png",width: 40,),
                    Text("No Books Available"),
                  ],
                ),
              )
              : Padding(
                padding: const EdgeInsets.only(top: 5),
                child: ListView.separated(
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap:
                          () => Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder:
                                  (context) => BookDetailsPage(
                                    bookModel: value.books[index],
                                    bookIndexNumber: index,
                                    popIdentifierString: "Home",
                                  ),
                            ),
                          ),
                      child: HomePageBookCardWidget(
                        allBooks: allBooks,
                        value: value,
                        listIndex: index,
                      ),
                    );
                  },
                  separatorBuilder: (context, index) {
                    return kh10;
                  },
                  itemCount: allBooks.length,
                ),
              );
        },
      ),
    );
  }
}
