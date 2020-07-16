import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:qrstocker/item.dart';

class Database {
  static String _key = HiveBox.items.toString();

  static Box<Item> _box;

  static Future init() async {
    await Hive.initFlutter();
    Hive.registerAdapter(ItemAdapter());
    _box = await Hive.openBox<Item>(_key);
  }

  static ValueListenable<Box<Item>> listenable() {
    return _box.listenable();
  }

  static void save(Item item) {
    if (item.isInBox) {
      item.save();
    } else {
      _box.add(item);
    }
  }

  static void delete(Item item) {
    item.delete();
  }
}

enum HiveBox {
  items,
}
