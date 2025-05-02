import 'dart:developer';
import 'package:book_buddy/models/book_model.dart';
import 'package:flutter/widgets.dart';
import 'package:hive_flutter/hive_flutter.dart';

class BookServicves extends ChangeNotifier {
  bool? isBookFavorite;
  late Box<BookModel> _booksBox;
  // List<BookModel> allBooks = [];

  List<BookModel> ongoingBooks = [];
  List<BookModel> wantToReadBooks = [];
  List<BookModel> completedBooks = [];
  List<BookModel> favoriteBooks = [];

  // void addBooksToCategory(List<BookModel> books){
  //      for (var element in books) {
  //       if(element.bookStatus == "Ongoing"){
  //         ongoingBooks.add(element);
  //       }else if(element.bookStatus == "Completed"){
  //         completedBooks.add(element);
  //       }else{
  //         wantToReadBooks.add(element);
  //       }
  //     }
  //     notifyListeners();
  // }

  void changeIsFavorite(BookModel bookModel){
    final newBookData = BookModel(
      id: bookModel.id,
      title: bookModel.title,
      authorName: bookModel.authorName,
      totalNumberOfPages: bookModel.totalNumberOfPages,
      pagesRead: bookModel.pagesRead,
      bookStatus: bookModel.bookStatus,
      imageUrl: bookModel.imageUrl,
      favorite: !bookModel.favorite,
    );
    log(newBookData.favorite.toString());
    _booksBox.put(newBookData.id,newBookData);
    updateBookCategories(books);
  }

  BookServicves(this._booksBox) {
    initializeCategories();
  }

  void initializeCategories() {
    updateBookCategories(_booksBox.values.toList());
  }

  void updateBookCategories(List<BookModel> books) {
    ongoingBooks = books.where((b) => b.bookStatus == "Ongoing").toList();
    wantToReadBooks =
        books.where((b) => b.bookStatus == "Want To Read").toList();
    completedBooks = books.where((b) => b.bookStatus == "Completed").toList();
    favoriteBooks = books.where((b) => b.favorite == true).toList();
    notifyListeners();
  }

  List<BookModel> get books => _booksBox.values.toList();

  // Future<void> initialize() async {
  // booksBox =  Hive.box<BookModel>(bookHiveBoxName);
  // }

  void addBook(BookModel bookDetails) async {
    // final db = Hive.box<BookModel>(bookHiveBoxName);
    await _booksBox.put(bookDetails.id, bookDetails);
    updateBookCategories(books);
  }

  void deleteBook(String id) async {
    // final db = Hive.box<BookModel>(bookHiveBoxName);
    // db.delete(id);
    // await _booksBox.delete(id);
    _booksBox.delete(id);
    updateBookCategories(books);
    // notifyListeners();
  }

  Future<void> updateBook(BookModel bookDetails) async {
    // final db = Hive.box<BookModel>(bookHiveBoxName);
    // _booksBox.put(bookDetails.id, bookDetails);
   await  _booksBox.put(bookDetails.id, bookDetails);
    updateBookCategories(books);
    // notifyListeners();
  }

  // void getAllBooksFromDb() async {
  //   final db = Hive.box<BookModel>(bookHiveBoxName);

  //   // books.clear();
  //   if (db.isNotEmpty) {
  //     // log(db.values.toList()[0].title);
  //     // books.addAll(db.values);
  //   } else {
  //     log("No items found in the database");
  //   }
  //   log("No items found in the database");
  //   notifyListeners();
  // }
}
