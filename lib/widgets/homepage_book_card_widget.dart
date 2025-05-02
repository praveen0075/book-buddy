import 'package:book_buddy/models/book_model.dart';
import 'package:book_buddy/provider/book_services.dart';
import 'package:book_buddy/styles/home_page_sytles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class HomePageBookCardWidget extends StatelessWidget {
  const HomePageBookCardWidget({
    super.key,
    required this.allBooks,
    required this.value,
    required this.listIndex,
  });

  final List<BookModel> allBooks;
  final BookServicves value;
  final int listIndex;

  @override
  Widget build(BuildContext context) {
    void deleteTheBook(String bookName) {
      try {
        value.deleteBook(value.books[listIndex].id);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              "You have deleted the book $bookName",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            backgroundColor: Colors.red,
          ),
        );
        Navigator.pop(context);
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              "Something Went Wrong",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            backgroundColor: Colors.red,
          ),
        );
      }
    }

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Container(
        // height : 200,
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(14)),
        child: Slidable(
          endActionPane: ActionPane(
            motion: DrawerMotion(),
            children: [
              SlidableAction(
                autoClose: true,
                label: "Delete",
                borderRadius: BorderRadius.circular(14),
                onPressed: (context) {
                  showDialog(
                    context: context,
                    builder:
                        (context) => AlertDialog(
                          title: Text(
                            "Are you sure?",
                            style: TextStyle(fontWeight: FontWeight.w500),
                            textAlign: TextAlign.start,
                          ),

                          // content: Text("Do you "),
                          actions: [
                            ElevatedButton(
                              style: ButtonStyle(
                                backgroundColor: WidgetStatePropertyAll(
                                  Colors.red.shade400,
                                ),
                              ),
                              onPressed: () {
                                deleteTheBook(value.books[listIndex].title);
                              },
                              child: Text(
                                "Delete",
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                            TextButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: Text("Cancel", style: TextStyle()),
                            ),
                          ],
                        ),
                  );
                },
                icon: Icons.delete,
                backgroundColor: Colors.red,
                // autoClose: true,
              ),
            ],
          ),
          child: Card(
            color: Colors.white,
            elevation: 5,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  child: Image.asset(
                    value.books[listIndex].imageUrl,
                    height: 80,
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      value.books[listIndex].title,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                    Text(value.books[listIndex].authorName),

                    Column(
                      children: [
                        SizedBox(height: 5),
                        SizedBox(
                          width: 180,
                          child: LinearProgressIndicator(
                            // trackGap: 3.5,
                            minHeight: 13.6,
                            borderRadius: BorderRadius.circular(2),
                            // backgroundColor: appBaseClr,
                            valueColor: AlwaysStoppedAnimation(
                              const Color.fromARGB(255, 159, 80, 167),
                            ),
                            value:
                                allBooks[listIndex].pagesRead /
                                allBooks[listIndex].totalNumberOfPages,
                            // trackGap: 2.5,
                          ),
                        ),
                        // Text(
                        //   "${allBooks[index].pagesRead}/${allBooks[index].totalNumberOfPages}",
                        // ),
                      ],
                    ),
                  ],
                ),
                SizedBox(
                  height: 70,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      // Icon(Icons.delete),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            // value.books[index].pagesRead.toString()
                            "${allBooks[listIndex].pagesRead}/${allBooks[listIndex].totalNumberOfPages}",
                            style: homePagebookPageCountTextStyle,
                          ),
                          Text(
                            "Pages",
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              color: Colors.black38,
                            ),
                          ),
                        ],
                      ),
                    ],
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
