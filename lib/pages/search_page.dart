import 'package:book_buddy/const.dart';
import 'package:book_buddy/models/temp_book_model.dart';
import 'package:book_buddy/pages/book_details_page.dart';
import 'package:book_buddy/styles/search_page_style.dart';
import 'package:book_buddy/utils/custom_delete_alertbox.dart';
import 'package:flutter/material.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  List<TempBookModel> books = [
    TempBookModel(
      title: "To kill a mockingbird",
      author: "Harper Lee",
      imageUrl: coverpages[0],
    ),
    TempBookModel(
      title: "1984",
      author: "George Orwell",
      imageUrl: coverpages[1],
    ),
    TempBookModel(
      title: "The Great Gatsby",
      author: "Jane Austen",
      imageUrl: "",
    ),
    TempBookModel(
      title: "The Catcher in the Rye",
      author: "F.Scott Fitzgerald",
      imageUrl: coverpages[0],
    ),
    TempBookModel(
      title: "The Lord of the Rings",
      author: "J.D. Salinger",
      imageUrl: coverpages[3],
    ),
    TempBookModel(
      title: "Dune",
      author: "J.R.R Tolkien",
      imageUrl: coverpages[2],
    ),
    TempBookModel(
      title: "Sapiens",
      author: "Yuval Noah Harari",
      imageUrl: coverpages[4],
    ),
    TempBookModel(
      title: "Atomic Habits",
      author: "James Clear",
      imageUrl: coverpages[5],
    ),
    TempBookModel(
      title: "The Alchemist",
      author: "Paulo Coelho",
      imageUrl: coverpages[1],
    ),
  ];

  final TextEditingController _searchController = TextEditingController();

  List<TempBookModel> filteredBook = [];

  @override
  void initState() {
    super.initState();
    filteredBook = books;
    _searchController.addListener(_filterBooks);
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _filterBooks() {
    final query = _searchController.text.toLowerCase();

    setState(() {
      filteredBook =
          books.where((tempBookModel) {
            final titleLower = tempBookModel.title.toLowerCase();
            final authorLower = tempBookModel.author.toLowerCase();
            return titleLower.contains(query) || authorLower.contains(query);
          }).toList();
    });
  }

  void deletItemShoDialog() {
    Navigator.pop(context);
    showDialog(
      context: context,
      builder: (context) {
        return CustomDeleteAlertBox(
          onTap1: () {
            /// delete the ite
          },
          onTap2: () => Navigator.pop(context),
        );
      },
    );
  }

  void onLongPress() {
    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            content: ListTile(
              onTap: () => deletItemShoDialog(),
              leading: Icon(Icons.delete, color: Colors.red),
              title: Text(
                "Delete",
                style: TextStyle(
                  color: Colors.red,
                  fontWeight: FontWeight.bold,
                ),
              ),
              // trailing: Icon(Icons.delete),
            ),
          ),
    );
  }

  @override
  Widget build(BuildContext context) {
    var mQuery = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: appScaffoldBackgroundColor,
      // appBar: AppBar(
      //   title: Text("Search"),
      // ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          kh20,
          kh20,
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              height: 50,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: TextFormField(
                  controller: _searchController,
                  decoration: InputDecoration(
                    hintText: "Search",
                    hintStyle: searchBarHintTextStyle,
                    suffixIcon:
                        _searchController.text.isNotEmpty
                            ? IconButton(
                              onPressed: () {
                                _searchController.clear();
                                _filterBooks();
                              },
                              icon: Icon(Icons.clear),
                            )
                            : Icon(
                              Icons.search,
                              color: Color.fromARGB(130, 0, 0, 0),
                            ),
                    border: OutlineInputBorder(borderSide: BorderSide.none),
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            child: ListView.separated(
              padding: EdgeInsets.zero,
              itemBuilder: (context, index) {
                final book = filteredBook[index];
                return ListTile(
                  onLongPress: () => onLongPress(),
                  onTap:
                      () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => BookDetailsPage(),
                        ),
                      ),
                  leading: SizedBox(
                    height: 55,
                    width: 55,
                    // color: Colors.blue,
                    child: Image.asset("assets/images/litebrowncoverpage.png"),
                  ),
                  title: Text(
                    book.title,
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                  subtitle: Text(
                    book.author,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.black54,
                    ),
                  ),
                  trailing: Text(
                    "Completed",
                    style: TextStyle(color: appBaseClr),
                  ),
                );
              },
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
              itemCount: filteredBook.length,
            ),
          ),
        ],
      ),
    );
  }
}
