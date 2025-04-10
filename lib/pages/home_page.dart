import 'package:book_buddy/const.dart';
import 'package:book_buddy/pages/add_newbook_page.dart';
import 'package:book_buddy/pages/book_details_page.dart';
import 'package:book_buddy/provider/book_services.dart';
import 'package:book_buddy/styles/home_page_sytles.dart';
import 'package:book_buddy/utils/custom_alertdialog.dart';
import 'package:book_buddy/utils/custom_appbar.dart';
import 'package:book_buddy/utils/custom_delete_alertbox.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<BookServicves>(context, listen: false).getAllBooksFromDb();
    });
  }

  void onTap2FunctionOfOnLongPress(BuildContext context) {
    Navigator.pop(context);
    showDialog(
      context: context,
      builder: (context) {
        return CustomDeleteAlertBox(
          onTap1: () {
            /// delete the item
          },
          onTap2: () => Navigator.pop(context),
        );
      },
    );
  }

  void onLongPressOnTile(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return CustomAlertDialog(
          leadingWidget1: Icon(Icons.edit),
          leadingWidget2: Icon(Icons.delete, color: Colors.red),
          titleWidget: Text("Options"),
          listTitle1: Text("Edit"),
          listTilte2: Text("Delete", style: TextStyle(color: Colors.red)),
          onTap1:
              () => Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => BookDetailsPage()),
              ),
          onTap2: () {
            onTap2FunctionOfOnLongPress(context);
          },
        );
      },
    );
  }

  // void onTapOnTile(
  @override
  Widget build(BuildContext context) {
    var pIndicatorValue = 12 / 50;
    var mQuery = MediaQuery.of(context).size;
    return Scaffold(
      // backgroundColor: appScaffoldBackgroundColor,
      floatingActionButton: SizedBox(
        width: 110,
        child: FloatingActionButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => AddNewbookPage()),
            );
          },
          backgroundColor: const Color.fromARGB(255, 156, 103, 161),
          child: Row(
            children: [
              kw5,
              Icon(Icons.add, color: Colors.white),
              kw5,
              Text("New Book", style: TextStyle(color: Colors.white)),
            ],
          ),
        ),
      ),
      appBar: PreferredSize(
        preferredSize: Size(mQuery.width, mQuery.height / 14),
        child: CustomAppBar(
          titleText: Text("BOOK BUDDY", style: homePageAppBartitleTextStyle),
          backgroundColor: appBaseClr,
        ),
      ),
      body: Consumer<BookServicves>(
        builder:
            (context, value, child) =>
                value.books.isEmpty
                    ? Center(child: Text("No data available"))
                    : ListView.separated(
                      itemBuilder: (context, index) {
                        return Slidable(
                          endActionPane: ActionPane(
                            motion: ScrollMotion(),
                            children: [
                              // SlidableAction(
                              //   onPressed: (context) {},
                              //   flex: 2,
                              //   icon: Icons.edit,

                              //   // label: "",
                              // ),
                              SlidableAction(
                                onPressed: (context) {},
                                icon: Icons.delete,
                                backgroundColor: Colors.red,
                                // label: "",
                              ),
                            ],
                          ),
                          child: ListTile(
                            // onTap:
                            //     () => onTapOnTile(
                            //       context,
                            //       "assets/images/litebrowncoverpage.png",
                            //       "The Power",
                            //       "Unkown",
                            //       "something a description but description is not something",
                            //     ),
                            onTap:
                                () => Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => BookDetailsPage(),
                                  ),
                                ),
                            onLongPress: () => onLongPressOnTile(context),
                            leading: SizedBox(
                              height: 55,
                              width: 55,
                              // color: Colors.blue,
                              child: Image.asset(
                                "assets/images/litebrowncoverpage.png",
                              ),
                            ),
                            title: Text(
                              value.books[index].title,
                              style: homePageBooksNameTextStyle,
                            ),
                            subtitle: LinearProgressIndicator(
                              minHeight: 13.6,
                              borderRadius: BorderRadius.circular(15),
                              // backgroundColor: appBaseClr,
                              valueColor: AlwaysStoppedAnimation(
                                const Color.fromARGB(255, 159, 80, 167),
                              ),
                              value: pIndicatorValue,
                              // trackGap: 2.5,
                            ),
                            trailing: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "${value.books[index].pagesRead}/${value.books[index].totalNumberOfPages}",
                                  style: homePagebookPageCountTextStyle,
                                ),
                                Text("Pages"),
                              ],
                            ),
                          ),
                        );
                      },
                      separatorBuilder: (context, index) {
                        return kh10;
                      },
                      itemCount: 10,
                    ),
      ),
    );
  }
}
