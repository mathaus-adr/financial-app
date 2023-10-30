import 'package:financialweb/models/person.dart';
import 'package:hive/hive.dart';

part 'bill.g.dart';

@HiveType(typeId: 1)
class Bill {
  @HiveField(0)
  late String name;
  @HiveField(1)
  late double preco;
  @HiveField(2)
  late Person? payedBy;
  Bill({required this.name, required this.preco, this.payedBy});
}
