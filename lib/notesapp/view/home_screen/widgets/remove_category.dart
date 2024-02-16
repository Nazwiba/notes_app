import 'package:flutter/material.dart';
import 'package:notes_app/notesapp/controller/controller.dart';
import 'package:notes_app/notesapp/utils/color_constants.dart';

class RemoveCategory extends StatelessWidget {
  RemoveCategory(
      {super.key,
      required this.categoryName,
      required this.categoryIndex,
      required this.fetchData});

  String categoryName;
  int categoryIndex;
  final void Function() fetchData;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text("Delete $categoryName ?"),
      actions: [
        ElevatedButton(
            style: ButtonStyle(
                backgroundColor:
                    MaterialStatePropertyAll(ColorConstants.primaryColor)),
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text("Cancel")),
        ElevatedButton(
            style: ButtonStyle(
                backgroundColor:
                    MaterialStatePropertyAll(ColorConstants.primaryColor)),
            onPressed: () {
              print(categoryIndex);
              print(categoryName);
              CategoryController().removeUserCategory(
                  catIndex: categoryIndex, fetchData: fetchData);
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: Text("$categoryName deleted successfully")));
              fetchData();
            },
            child: const Text("Delete"))
      ],
    );
  }
}
