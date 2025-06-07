import 'package:book_buddy/const.dart';
import 'package:book_buddy/models/book_model.dart';
import 'package:book_buddy/provider/book_services.dart';
import 'package:book_buddy/styles/library_page_styles.dart';
import 'package:book_buddy/widgets/library_items_widget.dart';
import 'package:book_buddy/widgets/library_page_booklist_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LibararyPage extends StatefulWidget {
  const LibararyPage({super.key});

  @override
  State<LibararyPage> createState() => _LibararyPageState();
}

class _LibararyPageState extends State<LibararyPage> {
  List<BookModel> allBooks = [];
  @override
  void initState() { 
    super.initState();
        WidgetsBinding.instance.addPostFrameCallback((_){
      final provider = Provider.of<BookServicves>(context,listen: false);
      provider.initializeCategories();
    });
  }

  @override
  Widget build(BuildContext context) {
   
    var mQuery = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: appScaffoldBackgroundColor,
      appBar:
      AppBar(
        title: Text("Library"),
        backgroundColor: appScaffoldBackgroundColor,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Consumer<BookServicves>(
          builder: (context,value,child) {
            
            return Column(
              children: [
                Container(
                  padding: EdgeInsets.all(15),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Colors.blue.shade100, Colors.purple.shade100],
                    ),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Column(
                    children: [
                      Icon(Icons.menu_book_rounded),
                      kh10,
                      Text(
                        "Books open doors to new worlds, spark creativity, and enrich our lives. Every page you read brings knowledge, inspiration, and growth. They help you explore new ideas, understand different perspectives, and escape into captivating stories. Dive into a book today and let the magic of reading transform your world. Happy reading!",
                        style: libraryPageInfoTextStyle,
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
                kh30,
                Column(
                  children: [
                    InkWell(
                      onTap:
                          () => Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder:
                                  (context) => LibraryPageBooklistWidget(
                                    bookModel: value.favoriteBooks,
                                    pageTitle: "Favourites",
                                  ),
                            ),
                          ),
                      child: LibraryItemsWidget(
                        titleText: "Favourites",
                        bookcount: "${value.favoriteBooks.length}",
                        iconData: Icons.favorite_border_outlined, 
                      ),
                    ),
                    Divider(),
                    InkWell(
                      onTap:
                          () => Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder:
                                  (context) => LibraryPageBooklistWidget(
                                    bookModel: value.ongoingBooks,
                                    pageTitle: "Ongoing",
                                  ),
                            ),
                          ),
                      child: LibraryItemsWidget(
                        titleText: "Ongoing",
                        bookcount: "${value.ongoingBooks.length}",
                        iconData: Icons.book_online_outlined,
                      ),
                    ),
                    Divider(),
                    InkWell(
                      onTap:
                          () => Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder:
                                  (context) => LibraryPageBooklistWidget(
                                    bookModel: value.wantToReadBooks,
                                    pageTitle: "Want to read",
                                  ),
                            ),
                          ),
                      child: LibraryItemsWidget(
                        titleText: "Want to read",
                        bookcount: "${value.wantToReadBooks.length}",
                        iconData: Icons.collections_bookmark_outlined,
                      ),
                    ),
                    kh10,
                    InkWell(
                      onTap:
                          () => Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder:
                                  (context) => LibraryPageBooklistWidget(
                                    bookModel: value.completedBooks,
                                    pageTitle: "Completed",
                                  ),
                            ),
                          ),
                      child: LibraryItemsWidget( 
                        titleText: "Completed",
                        bookcount: "${value.completedBooks.length}",
                        iconData: Icons.bookmark_added_outlined,
                      ),
                    ),
                  ],
                ),
                kh40,
              ],
            );
          }
        ),
      ),
    );
  }
}
