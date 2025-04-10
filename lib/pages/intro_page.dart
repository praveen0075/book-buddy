import 'package:book_buddy/const.dart';
import 'package:book_buddy/pages/username_input_page.dart';
import 'package:book_buddy/styles/intro_page_styles.dart';
import 'package:book_buddy/utils/custom_buttton1.dart';
import 'package:flutter/material.dart';

class IntroPage extends StatelessWidget {
  const IntroPage({super.key});

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
            // child: Text("jsldfljllsadjlfjljsdlfjl;jlasjdfljlsdjfljsdl;fjldfjljsdfljljlsadjfljsldjflsjdlfjlsadjfflj"),
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
                      "Organize and Track your \n Reading Goals",
                      style: introTitleStyle,
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    child: Text(
                      "Your personal reading assistant to help you organize, track and complete books effortlessly",
                      style: introSubTitleStyle,
                      textAlign: TextAlign.center,
                    ),
                  ),
                  SizedBox(height: 30),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => UserNameInputPage(),
                        ),
                      );


                    },
                    child: CustomButtton1(
                      color: Color.fromARGB(196, 110, 18, 118),
                      txtStyle: introContinuebuttonTextStyle,
                      btnTxt: "Continue ",
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
