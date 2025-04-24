
import 'package:book_buddy/models/book_model.dart';
import 'package:flutter/widgets.dart';
import 'package:hive_flutter/hive_flutter.dart';

class BookServicves extends ChangeNotifier {
  late Box<BookModel> _booksBox;

  BookServicves(this._booksBox); 

  List<BookModel> get books => _booksBox.values.toList();

  // Future<void> initialize() async {
  // booksBox =  Hive.box<BookModel>(bookHiveBoxName);
  // }

  void addBook(BookModel bookDetails) async {
    // final db = Hive.box<BookModel>(bookHiveBoxName);
    await _booksBox.put(bookDetails.id,bookDetails);
    notifyListeners();
  }

  void deleteBook(String id) async {
    // final db = Hive.box<BookModel>(bookHiveBoxName);
    // db.delete(id);
    // await _booksBox.delete(id);
    _booksBox.delete(id);
    notifyListeners();
  }

  void updateBook(BookModel bookDetails) async {
    // final db = Hive.box<BookModel>(bookHiveBoxName);
    // _booksBox.put(bookDetails.id, bookDetails);
    _booksBox.put(bookDetails.id,bookDetails);
    notifyListeners();
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
