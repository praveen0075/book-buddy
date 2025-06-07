import 'package:book_buddy/const.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

class CustomBottomNavBar extends StatelessWidget {
  void Function(int) ontap;
  CustomBottomNavBar({super.key, required this.ontap});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 5),
      child: GNav(
        tabMargin: EdgeInsets.all(8),
        backgroundColor: Colors.grey.shade100,
        padding: EdgeInsets.all(15),
        tabBorderRadius: 10,
        mainAxisAlignment: MainAxisAlignment.center,
        color: Colors.grey,
        textStyle: TextStyle(color: Colors.white),
        activeColor: Colors.white,
        tabBackgroundGradient: LinearGradient(
          colors: [
            appBaseClr,
            appBaseClr,
            const Color.fromARGB(255, 135, 50, 143),
            const Color.fromARGB(255, 191, 146, 196),
          ],
        ), 
        onTabChange: (value) => ontap(value),
        tabs: [
          GButton(icon: Icons.home, text: "Home"),
          GButton(icon: Icons.search_rounded, text: "Search"),
          GButton(icon: Icons.library_books_outlined, text: "Library"),
        ],
      ),
    );
  }
}
