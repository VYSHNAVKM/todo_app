import 'package:hive_flutter/adapters.dart';

part 'my_name_model.g.dart';

@HiveType(typeId: 0)
class MyNameModel {
  @HiveField(0)
  String title;
  @HiveField(1)
  String description;
  @HiveField(2)
  DateTime date;
  @HiveField(3)
  int selectColor;

  @HiveField(4)
  int? key;

  MyNameModel(
      {required this.selectColor,
      required this.date,
      required this.description,
      required this.title,
      this.key});

  static copy(MyNameModel existingNote) {}
}
