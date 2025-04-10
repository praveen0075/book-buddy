import 'dart:developer';

import 'package:book_buddy/main.dart';
import 'package:book_buddy/models/book_model.dart';
import 'package:flutter/widgets.dart';
import 'package:hive_flutter/hive_flutter.dart';

class BookServicves extends ChangeNotifier {
  List<BookModel> books = [];

  void addBook(BookModel bookDetails) async {
    final db = Hive.box<BookModel>(bookHiveBoxName);
    db.put(bookDetails.id, bookDetails);
    notifyListeners();
  }

  void deleteBook(String id) async {
    final db = Hive.box<BookModel>(bookHiveBoxName);
    db.delete(id);
    notifyListeners();
  }

  void updateBook(BookModel bookDetails) async {
    final db = Hive.box<BookModel>(bookHiveBoxName);
    db.put(bookDetails.id, bookDetails);
    notifyListeners();
  }

  void getAllBooksFromDb() async {
    final db = Hive.box<BookModel>(bookHiveBoxName);
    books.clear();
    if (db.isNotEmpty) {
      books.addAll(db.values);
    } else {
      log("No items found in the database");
    }
    log("No items found in the database");
    notifyListeners();
  }
}
