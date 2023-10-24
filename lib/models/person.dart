import 'package:hive/hive.dart';

part 'person.g.dart';

@HiveType(typeId: 2)
class Person {
  @HiveField(0)
  late String name;

  Person({required this.name});
}
