import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:intl/intl.dart';
import 'package:notes_app/notesapp/model/notes_model.dart';
import 'package:notes_app/notesapp/utils/color_constants.dart';
import 'package:notes_app/notesapp/view/home_screen/widgets/note_widget.dart';

import '../../controller/controller.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var notebox = Hive.box('noteBox');
  // adding form key
  final _formKey = GlobalKey<FormState>();

  //notes controller object
  NotesController notesController = NotesController();

  // adding controller
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  // category list from hive category box
  List categories = [];

  //Index of selected category
  int categoryIndex = 0;

  // category controller object
  CategoryController catController = CategoryController();

  // category controller
  TextEditingController categoryController = TextEditingController();

  //keys list
  List mykeysList = [];

  bool isEditing = false;
  @override
  void initState() {
    catController.initializeApp();
    categories = catController.getAllcategories();
    fetchData();
    super.initState();
  }

  void fetchData() {
    mykeysList = notebox.keys.toList();
    categories = catController.getAllcategories();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 237, 230, 168),
      floatingActionButton: FloatingActionButton(
        shape: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: const BorderSide(width: 2, color: Colors.white)),
        elevation: 0,
        onPressed: () => bottomsheet(context),
        backgroundColor: ColorConstants.secondaryColor2,
        child: const Icon(Icons.add),
      ),
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.only(top: 30, left: 20),
        child: ListView.separated(
            itemBuilder: (context, index) {
              List<NotesModel> notesInCategory =
                  notebox.get(mykeysList[index])!.cast<NotesModel>();
              return Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      categories[mykeysList[index]],
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w700,
                          color: ColorConstants.primaryColor),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children:
                            List.generate(notesInCategory.length, (inIndex) {
                          return NoteWidget(
                            title: notesInCategory[
                                    notesInCategory.length - inIndex - 1]
                                .title,
                            description: notesInCategory[
                                    notesInCategory.length - inIndex - 1]
                                .description,
                            date: notesInCategory[
                                    notesInCategory.length - inIndex - 1]
                                .date,
                            category: categories[mykeysList[index]],
                            onDelete: () {
                              print(
                                  "index1: ${notesInCategory.length - inIndex - 1}");
                              notesController.deleteNote(
                                key: mykeysList[index],
                                note: notesInCategory[
                                    notesInCategory.length - inIndex - 1],
                                fetchData: fetchData,
                                index: notesInCategory.length - inIndex - 1,
                              );
                              fetchData();
                              setState(() {});
                            },
                            onUpdate: () {
                              titleController.text = notesInCategory[
                                      notesInCategory.length - inIndex - 1]
                                  .title;
                              descriptionController.text = notesInCategory[
                                      notesInCategory.length - inIndex - 1]
                                  .description;
                              categoryIndex = notesInCategory[
                                      notesInCategory.length - inIndex - 1]
                                  .category;
                              isEditing = true;
                              bottomsheet(context,
                                  key: mykeysList[index],
                                  indexOfEditing:
                                      notesInCategory.length - inIndex - 1,
                                  currentCategory: notesInCategory[
                                          notesInCategory.length - inIndex - 1]
                                      .category);
                              setState(() {});
                            },
                          );
                        }),
                      ),
                    )
                  ],
                ),
              );
            },
            separatorBuilder: (context, index) => const Divider(height: 20),
            itemCount: mykeysList.length),
      )),
    );
  }

  Future<dynamic> bottomsheet(BuildContext context,
      {var key, int? indexOfEditing, int? currentCategory}) {
    return showModalBottomSheet(
        backgroundColor: ColorConstants.primaryBackgroundColor,
        shape: const OutlineInputBorder(
          borderSide: BorderSide(width: 0),
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(15),
            topRight: Radius.circular(15),
          ),
        ),
        isScrollControlled: true,
        context: context,
        builder: (context) => StatefulBuilder(
              builder: (context, InsetState) => Padding(
                // InSetState = setState we write any name
                padding: EdgeInsets.only(
                    bottom: MediaQuery.of(context).viewInsets.bottom),
                child: SingleChildScrollView(
                  child: Container(
                    padding: const EdgeInsets.all(20),
                    child: Form(
                        key: _formKey,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            TextFormField(
                              controller: titleController,
                              maxLines: 1,
                              decoration: InputDecoration(
                                labelText: "Title",
                                labelStyle: TextStyle(
                                    color: ColorConstants.primaryColor,
                                    fontWeight: FontWeight.bold),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: ColorConstants.primaryColor,
                                      width: 2),
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15),
                                  borderSide: BorderSide(
                                      color: ColorConstants.primaryColor),
                                ),
                                isDense: false,
                                contentPadding: const EdgeInsets.all(20),
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return "Please enter the Title";
                                }
                                return null;
                              },
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            SizedBox(
                              height: 150,
                              child: TextFormField(
                                controller: descriptionController,
                                maxLines: null,
                                expands: true,
                                textAlignVertical: TextAlignVertical.top,
                                textAlign: TextAlign.start,
                                keyboardType: TextInputType.multiline,
                                decoration: InputDecoration(
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: ColorConstants.primaryColor,
                                        width: 2),
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                  hintText: "Description",
                                  hintStyle: TextStyle(
                                      color: ColorConstants.primaryColor),
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(15),
                                      borderSide: BorderSide(
                                          color: ColorConstants.primaryColor)),
                                  isDense: false,
                                  contentPadding: const EdgeInsets.all(20),
                                ),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return "Please enter decription";
                                  }
                                  return null;
                                },
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            Text(
                              "Category",
                              style: TextStyle(
                                  color: ColorConstants.primaryColor,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Row(
                                children: List.generate(
                                    categories.length + 1,
                                    (index) => index == categories.length
                                        ? InkWell(
                                            onTap: () =>
                                                catController.addCategory(
                                                    context: context,
                                                    categoryController:
                                                        categoryController,
                                                    catController:
                                                        catController,
                                                    fetchdata: fetchData),
                                            child: Container(
                                              padding: const EdgeInsetsDirectional
                                                  .symmetric(
                                                      horizontal: 15,
                                                      vertical: 10),
                                              decoration: BoxDecoration(
                                                  color: Colors.black,
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10)),
                                              child: const Text(
                                                " + Add Category",
                                                style: TextStyle(
                                                    fontSize: 15,
                                                    fontWeight: FontWeight.w600,
                                                    color: Colors.white),
                                              ),
                                            ),
                                          )
                                        : Padding(
                                            padding: const EdgeInsets.only(right: 15),
                                            child: InkWell(
                                              onTap: () {
                                                categoryIndex = index;
                                                InsetState(() {});
                                              },
                                              onLongPress: () {
                                                print(index);
                                                print(categories[index]
                                                    .toString());
                                                catController.removeCategory(
                                                    catIndex: index,
                                                    catName: categories[index]
                                                        .toString(),
                                                    context: context,
                                                    fetchData: fetchData);
                                                fetchData();
                                                setState(() {});
                                                InsetState(() {});
                                              },
                                              child: Container(
                                                padding: const EdgeInsetsDirectional
                                                    .symmetric(
                                                        horizontal: 15,
                                                        vertical: 10),
                                                decoration: BoxDecoration(
                                                    color: categoryIndex ==
                                                            index
                                                        ? Colors.black
                                                        : ColorConstants
                                                            .secondaryCardColor,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10)),
                                                child: Text(
                                                  categories[index].toString(),
                                                  style: const TextStyle(
                                                      fontSize: 15,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Colors.white),
                                                ),
                                              ),
                                            ),
                                          )),
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SizedBox(
                                  width: 100,
                                  child: ElevatedButton(
                                      style: ButtonStyle(
                                          backgroundColor:
                                              MaterialStatePropertyAll(
                                                  ColorConstants.primaryColor)),
                                      onPressed: () {
                                        titleController.clear();
                                        descriptionController.clear();
                                        Navigator.pop(context);
                                        isEditing = false;
                                        setState(() {});
                                      },
                                      child: const Text("Cancel")),
                                ),
                                const SizedBox(
                                  width: 30,
                                ),
                                SizedBox(
                                  width: 80,
                                  child: ElevatedButton(
                                      style: ButtonStyle(
                                          backgroundColor:
                                              MaterialStatePropertyAll(
                                                  ColorConstants.primaryColor)),
                                      onPressed: () {
                                        if (isEditing) {
                                          notesController.editNote(
                                              title: titleController.text,
                                              description:
                                                  descriptionController.text,
                                              date: DateFormat('dd:MM:yyyy')
                                                  .format(DateTime.now())
                                                  .toString(),
                                              category: categoryIndex,
                                              oldCategory: currentCategory!,
                                              formkey: _formKey,
                                              indexOfNote: indexOfEditing!);
                                          isEditing = false;
                                          titleController.clear();
                                          descriptionController.clear();
                                          fetchData();
                                          categoryIndex = 0;
                                          Navigator.pop(context);
                                        } else {
                                          notesController.addNotes(
                                              formkey: _formKey,
                                              title: titleController.text,
                                              description:
                                                  descriptionController.text,
                                              titleController: titleController,
                                              date: DateFormat('dd:MM:yyyy')
                                                  .format(DateTime.now())
                                                  .toString(),
                                              category: categoryIndex,
                                              context: context,
                                              desController:
                                                  descriptionController);
                                          fetchData();
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(const SnackBar(
                                                  content:
                                                      Text("Note added ")));
                                          setState(() {});
                                        }
                                      },
                                      child: isEditing
                                          ? const Text("Edit")
                                          : const Text("Add")),
                                )
                              ],
                            )
                          ],
                        )),
                  ),
                ),
              ),
            ));
  }
}
