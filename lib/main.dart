import 'package:book_buddy/const.dart';
import 'package:book_buddy/models/book_model.dart';
import 'package:book_buddy/pages/intro_page.dart';
import 'package:book_buddy/provider/book_services.dart';
import 'package:book_buddy/provider/cover_image_selection.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';

String bookHiveBoxName = "book_box";

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  if (!Hive.isAdapterRegistered(BookModelAdapter().typeId)) {
    Hive.registerAdapter(BookModelAdapter());
  }
  final bookBox = await Hive.openBox<BookModel>(bookHiveBoxName);
  runApp(MyApp(bookBox: bookBox));
}

class MyApp extends StatelessWidget {
  Box<BookModel> bookBox;
  MyApp({super.key, required this.bookBox});
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => BookServicves(bookBox)),
        ChangeNotifierProvider(
          create: (context) => CoverImageSelection(coverpages),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        ),
        home: IntroPage(),
      ),
    );
  }
}
