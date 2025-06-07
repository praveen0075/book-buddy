import 'package:flutter/widgets.dart';

class CoverImageSelection with ChangeNotifier {
  int? selectedIndex;
  List<String> coverPageUrl;
  CoverImageSelection(this.coverPageUrl);

  String? getSelectedImageUrl() {
    return selectedIndex != null ? coverPageUrl[selectedIndex!] : null;
  }

  void  selectItem(int index) {
    selectedIndex = selectedIndex == index ? null : index;
    notifyListeners();
  }
  
  void clearSelection() {
    selectedIndex = null;
    notifyListeners();
  }
}
