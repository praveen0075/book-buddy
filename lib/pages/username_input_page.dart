import 'package:book_buddy/const.dart';
import 'package:book_buddy/pages/nav_controlling.dart';
import 'package:book_buddy/styles/intro_page_styles.dart';
import 'package:book_buddy/utils/custom_buttton1.dart';
import 'package:flutter/material.dart';

class UserNameInputPage extends StatelessWidget {
  const UserNameInputPage({super.key});

  @override
  Widget build(BuildContext context) {
    var mQuery = MediaQuery.of(context).size;
    return Scaffold(
      body: Stack(
        children: [
          Container(
            width: mQuery.width,
            height: mQuery.height,
            decoration: BoxDecoration(color: appBaseClr),
            child: Column(
              children: [
                SizedBox(height: 170),
                Image.asset("assets/images/readingbook1.png", width: 340),
              ],
            ),
          ),
          Positioned(
            right: 0,
            left: 0,
            bottom: 0,
            child: Container(
              height: mQuery.height / 3,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(35),
                  topLeft: Radius.circular(35),
                ),
              ),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(15),
                    child: Text(
                      "Enter your name here..",
                      style: introTitleStyle,
                      textAlign: TextAlign.start,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 28),
                    child: TextField(
                      decoration: InputDecoration(
                        label: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: Text("Name"),
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(25),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 30),
                  GestureDetector(
                    onTap: () {
                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                          builder: (context) => NavcontrollingPage(),
                        ),
                        (route) => false,
                      );
                    },
                    child: CustomButtton1(
                      color: Color.fromARGB(196, 110, 18, 118),
                      txtStyle: introContinuebuttonTextStyle,
                      btnTxt: "Submit",
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
