import 'package:financialweb/models/person.dart';
import 'package:hive/hive.dart';


@HiveType(typeId: 1)
class Bill {
  @HiveField(0)
  late String name;
  @HiveField(1)
  late double preco;
  @HiveField(2)
  late Person? payedBy;
  @HiveField(3)
  late int? id;
  Bill({required this.name, required this.preco, this.payedBy, this.id});

  toJson() => {"name": name, "preco": preco, "payedBy": payedBy, "id" : id};
}
