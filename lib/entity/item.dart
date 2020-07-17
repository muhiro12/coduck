import 'package:hive/hive.dart';

part 'item.g.dart';

@HiveType(typeId: 0)
class Item extends HiveObject {
  @HiveField(0)
  final DateTime updatedAt = DateTime.now();

  @HiveField(1)
  String title = '';

  @HiveField(2)
  String data = '';

  @HiveField(3)
  String note = '';
}
