import 'package:book_buddy/const.dart';
import 'package:book_buddy/models/book_model.dart';
import 'package:book_buddy/pages/book_details_page.dart';
import 'package:book_buddy/provider/book_services.dart';
import 'package:book_buddy/styles/search_page_style.dart';
import 'package:book_buddy/utils/custom_delete_alertbox.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final TextEditingController _searchController = TextEditingController();
  late BookServicves _bookProvider;

  @override
  void initState() {
    super.initState();
    _searchController.addListener(_filterBooks);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _bookProvider = Provider.of<BookServicves>(context, listen: false);
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _filterBooks() {
    setState(() {}); // Trigger rebuild when search text changes
  }

  List<BookModel> get filteredBooks {
    final query = _searchController.text.toLowerCase();
    if (query.isEmpty) {
      return _bookProvider.books;
    }
    return _bookProvider.books.where((book) {
      return book.title.toLowerCase().contains(query) ||
          book.authorName.toLowerCase().contains(query);
    }).toList();
  }

  void _showDeleteDialog(String bookId) {
    showDialog(
      context: context,
      builder:
          (context) => CustomDeleteAlertBox(
            onTap1: () {
              _bookProvider.deleteBook(bookId);
              Navigator.pop(context);
            },
            onTap2: () => Navigator.pop(context),
          ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appScaffoldBackgroundColor,
      body: Column(
        children: [
          const SizedBox(height: 20),
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
                              icon: const Icon(Icons.clear),
                            )
                            : const Icon(
                              Icons.search,
                              color: Color.fromARGB(130, 0, 0, 0),
                            ),
                    border: const OutlineInputBorder(
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            child: Consumer<BookServicves>(
              builder: (context, provider, child) {
                if (filteredBooks.isEmpty) {
                  return Center(
                    child: Text(
                      _searchController.text.isEmpty
                          ? "No books available"
                          : "No books found for ${_searchController.text}",
                    ),
                  );
                }

                return ListView.separated(
                  padding: EdgeInsets.zero,
                  itemCount: filteredBooks.length,
                  separatorBuilder:
                      (context, index) => const SizedBox(height: 10),
                  itemBuilder: (context, index) {
                    final book = filteredBooks[index];
                    return ListTile(
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context) => BookDetailsPage(bookModel:book,bookIndexNumber: index,),));
                      },
                      onLongPress: () => _showDeleteDialog(book.id),
                      leading: SizedBox(
                        height: 55,
                        width: 55,
                        child: Image.asset(book.imageUrl),
                      ),
                      title: Text(
                        book.title,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                      subtitle: Text(
                        book.authorName,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.black54,
                        ),
                      ),
                      trailing: Text(
                        book.bookStatus,
                        style: TextStyle(color: appBaseClr),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
