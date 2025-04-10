import 'dart:developer';

import 'package:book_buddy/pages/home_page.dart';
import 'package:book_buddy/pages/libarary_page.dart';
import 'package:book_buddy/pages/profile_page.dart';
import 'package:book_buddy/pages/search_page.dart';
import 'package:book_buddy/utils/bottum_navbar.dart';
import 'package:flutter/material.dart';

class NavcontrollingPage extends StatefulWidget {
  const NavcontrollingPage({super.key});

  @override
  State<NavcontrollingPage> createState() => _NavcontrollingPageState();
}

class _NavcontrollingPageState extends State<NavcontrollingPage> {
  int selectedIndex = 0;
  List pages = [HomePage(), SearchPage(), LibararyPage(), ProfilePage()];

  void ontapChangeFunction(int indx) {
    setState(() {
      selectedIndex = indx;
    });
    log(selectedIndex.toString());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: CustomBottomNavBar(
        ontap: (value) => ontapChangeFunction(value),
      ),
      body: pages[selectedIndex],
    );
  }
}
