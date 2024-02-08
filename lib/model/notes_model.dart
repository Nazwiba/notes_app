import 'package:hive_flutter/adapters.dart';
part 'notes_model.g.dart'; // to add this file run the command on the terminal = flutter packages pub run build_runner build

@HiveType(typeId: 1)
class NotesModel {
  @HiveField(0)
  String title;
  @HiveField(1)
  String description;
  @HiveField(2)
  String date;
  @HiveField(3)
  int category;

  NotesModel({
    required this.title,
    required this.description,
    required this.date,
    required this.category,
  });
}
