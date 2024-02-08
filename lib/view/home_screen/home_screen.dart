import 'package:flutter/material.dart';
import 'package:notes_app/utils/color_constants.dart';

import '../../controller/controller.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // adding form key
  final _formKey = GlobalKey<FormState>();

  // adding controller
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  // category list from hive category box
  List categories = [];

  // category controller object
  CategoryController catController = CategoryController();
  
  // category controller
  TextEditingController categoryController = TextEditingController();
  @override
  void initState() {
    catController.initializeApp();
    categories = catController.getAllcategories();
    fetchData();
    super.initState();
  }
  fetchData(){

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstants.primaryBackgroundColor,
      floatingActionButton: FloatingActionButton(
        shape: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: const BorderSide(width: 2, color: Colors.white)),
        elevation: 0,
        onPressed: () => bottomsheet(context),
        backgroundColor: ColorConstants.secondaryColor2,
        child: const Icon(Icons.add),
      ),
    );
  }

  bottomsheet(
    BuildContext context,
  ) {
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
                            // SingleChildScrollView(
                            //   scrollDirection: Axis.horizontal,
                            //   child: Row(
                            //     children: List.generate(
                            //       categories.length + 1,
                            //         (index) => index == categories.length
                            //         ? InkWell(
                            //           onTap: () => catController.addCategory(
                            //             context: context,
                            //             categoryController:categoryController,
                            //             catController:catController,
                            //           ),
                            //         )),
                            //   ),
                            // )
                          ],
                        )),
                  ),
                ),
              ),
            ));
  }
}
