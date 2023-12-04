import 'package:hive/hive.dart';

@HiveType(typeId: 2)
class Person {
  @HiveField(0)
  late String name;
  
  @HiveField(0)
  late int? id;

  Person({required this.name, this.id});

  toJson() => {"name": name, "id": id};
}
