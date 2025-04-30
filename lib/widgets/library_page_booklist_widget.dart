import 'package:book_buddy/const.dart';
import 'package:book_buddy/models/book_model.dart';
import 'package:book_buddy/pages/book_details_page.dart';
import 'package:book_buddy/utils/custom_appbar.dart';
import 'package:flutter/material.dart';

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
      body: ListView.separated(
        padding: EdgeInsets.zero,
        itemBuilder:
            (context, index) => ListTile(
              onTap:
                  () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder:
                          (context) =>
                              BookDetailsPage(bookModel: bookModel[index],bookIndexNumber: index,),
                    ),
                  ),
              leading: SizedBox(
                height: 55,
                width: 55,
                // color: Colors.blue,
                child: Image.asset(bookModel[index].imageUrl),
              ),
              title: Text(
                bookModel[index].title,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
              subtitle: Text(
                bookModel[index].authorName,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.black54,
                ),
              ),
              // trailing: Text("Completed", style: TextStyle(color: appBaseClr)),
            ),
        // Padding(
        //   padding: const EdgeInsets.all(8.0),
        //   // child: Container(
        //   //   height: 80,
        //   //   decoration: BoxDecoration(
        //   //     borderRadius: BorderRadius.circular(15),
        //   //     color: Colors.blue
        //   //   ),
        //   // ),
        // ),
        separatorBuilder: (context, index) => kh10,
        itemCount: bookModel.length,
      ),
    );
  }
}
