import 'package:flutter/cupertino.dart';
import 'package:hive/hive.dart';

part 'item.g.dart';

@HiveType(typeId: 0)
class Item extends HiveObject {
  @HiveField(0)
  final String key = UniqueKey().toString();

  @HiveField(1)
  final DateTime createdAt = DateTime.now();

  @HiveField(2)
  String title;

  @HiveField(3)
  String qrText;
}
