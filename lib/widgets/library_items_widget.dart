import 'package:book_buddy/const.dart';
import 'package:book_buddy/styles/library_page_styles.dart';
import 'package:flutter/material.dart';

class LibraryItemsWidget extends StatelessWidget {
  String titleText;
  String bookcount;
  IconData iconData;
  LibraryItemsWidget({
    super.key,
    required this.titleText,
    required this.bookcount,
    required this.iconData,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Container(
              height: 65,
              width: 65,
              decoration: BoxDecoration(
                // color: const Color.fromARGB(45, 110, 18, 118),
                borderRadius: BorderRadius.circular(10), 
              ),
              child: Center(
                child: Container(
                  height: 50,
                  width: 50,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: Icon(iconData,color: const Color.fromARGB(173, 110, 18, 118),),
                ),
              ),
            ),
            kw10,
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(titleText, style: libraryPageItemTitleTextStyle),
                Text(
                  "$bookcount Books",
                  style: libraryPageItemSubTitleTextStyle,
                ),
              ],
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.only(right: 10),
          child: Icon(Icons.keyboard_arrow_right),
        ),
      ],
    );
  }
}
