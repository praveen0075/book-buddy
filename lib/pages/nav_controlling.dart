import 'dart:developer';

import 'package:book_buddy/pages/home_page.dart';
import 'package:book_buddy/pages/libarary_page.dart';
import 'package:book_buddy/pages/search_page.dart';
import 'package:book_buddy/utils/bottum_navbar.dart';
import 'package:flutter/material.dart';

class NavcontrollingPage extends StatefulWidget {
   NavcontrollingPage({super.key,this.popHelperInt});
  int? popHelperInt;

  @override
  State<NavcontrollingPage> createState() => _NavcontrollingPageState();
}

class _NavcontrollingPageState extends State<NavcontrollingPage> {
  int selectedIndex = 0;
  List pages = [HomePage(), SearchPage(), LibararyPage()];

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
