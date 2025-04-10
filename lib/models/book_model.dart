import 'package:hive_flutter/hive_flutter.dart';

part 'book_model.g.dart';

@HiveType(typeId: 0)
class BookModel {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String title;

  @HiveField(2)
  final String authorName;

  @HiveField(3)
  final int totalNumberOfPages;

  @HiveField(4)
  final int pagesRead;

  @HiveField(5)
  final String bookStatus;

  @HiveField(6)
  final String imageUrl;

  @HiveField(7)
  final String? description;

  @HiveField(8)
  final bool? favorite;

  BookModel({
    required this.id,
    required this.title,
    required this.authorName,
    required this.totalNumberOfPages,
    required this.pagesRead,
    required this.bookStatus,
    required this.imageUrl,
    this.description,
    this.favorite
  });
}
