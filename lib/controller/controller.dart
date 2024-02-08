import 'package:flutter/src/widgets/editable_text.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:hive_flutter/hive_flutter.dart';

class CategoryController {
  final CatBox = Hive.box('categories');

  void initializeApp() async {
    // List of default categories
    List<String> defaultCategories = ['work', 'Personal', 'Ideas'];
    // check if categories already exist
    bool categoriesExist = CatBox.isNotEmpty;
    //if default categories don't exist add them
    if (!categoriesExist) {
      for (String categoryName in defaultCategories) {
        CatBox.add(categoryName);
      }
    }
  }

  // funaction to get all categories
  List getAllcategories() {
    return CatBox.values.toList();
  }

  addCategory({required BuildContext context, required TextEditingController categoryController, required CategoryController catController}) {}
}
