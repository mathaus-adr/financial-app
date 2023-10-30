import 'package:hive/hive.dart';

part 'user.g.dart';

@HiveType(typeId: 3)
class User {
  @HiveField(0)
  late String name;
  @HiveField(1)
  late String email;
  @HiveField(2)
  late String password;
  User({required this.name, required this.email, required this.password});
}
