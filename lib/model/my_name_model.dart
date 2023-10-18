import 'package:hive_flutter/adapters.dart';

part 'my_name_model.g.dart';

@HiveType(typeId: 0)
class MyNameModel {
  @HiveField(0)
  late String title;
  @HiveField(1)
  late String description;
  @HiveField(2)
  late DateTime date;
  @HiveField(3)
  late int color;

  MyNameModel({
    required this.title,
    required this.description,
    required this.date,
    required this.color,
  });

  MyNameModel.copy(MyNameModel other) {
    title = other.title;
    description = other.description;
    date = other.date;
    color = other.color;
  }
}
