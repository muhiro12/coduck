import 'package:hive/hive.dart';

part 'code.g.dart';

@HiveType(typeId: 0)
class Code extends HiveObject {
  Code(
    this.type,
    this.data,
  ) : title = data;

  @HiveField(0)
  DateTime updatedAt = DateTime.now();

  @HiveField(1)
  final int type;

  @HiveField(2)
  final String data;

  @HiveField(3)
  String title;

  @HiveField(4)
  String note = '';
}
