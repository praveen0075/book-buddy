import 'package:book_buddy/const.dart';
import 'package:book_buddy/models/book_model.dart';
import 'package:book_buddy/provider/book_services.dart';
import 'package:book_buddy/utils/custom_appbar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LibraryPageBooklistWidget extends StatelessWidget {
  String pageTitle;
  List<BookModel> bookModel;
  LibraryPageBooklistWidget({
    super.key,
    required this.pageTitle,
    required this.bookModel,
  });

  @override
  Widget build(BuildContext context) {
    var mQuery = MediaQuery.of(context).size;
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size(mQuery.width, mQuery.height / 14),
        child: CustomAppBar(
          titleText: Text(
            pageTitle,
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
          backgroundColor: appBaseClr,
        ),
      ),
      body: Consumer<BookServicves>(
        builder: (context, value, child) {
          List<BookModel> currentBook;
          switch (pageTitle) {
            case "Favourites":
              currentBook = value.favoriteBooks;
              break;
            case "Ongoing":
              currentBook = value.ongoingBooks;
              break;
            case "Want to read":
              currentBook = value.wantToReadBooks;
              break;
            case "Completed":
              currentBook = value.completedBooks;
            default:
              currentBook = bookModel;
          }
          return currentBook == [] || currentBook.isEmpty
              ? Center(child: Text("No Books Available"))
              : ListView.separated(
                padding: EdgeInsets.zero,
                itemBuilder:
                    (context, index) => ListTile(
                      leading: SizedBox(
                        height: 55,
                        width: 55,
                        // color: Colors.blue,
                        child: Image.asset(bookModel[index].imageUrl),
                      ),
                      title: Text(
                        bookModel[index].title,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                      subtitle: Text(
                        bookModel[index].authorName,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.black54,
                        ),
                      ),
                    ),
                separatorBuilder: (context, index) => kh10,
                itemCount: bookModel.length,
              );
        },
      ),
    );
  }
}
