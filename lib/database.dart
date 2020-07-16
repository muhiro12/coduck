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

  static Future<bool> save(Item item) async {
    if (_box.length > 9) {
      return false;
    }
    if (item.isInBox) {
      await item.save();
    } else {
      await _box.add(item);
    }
    return true;
  }

  static void delete(Item item) {
    item.delete();
  }
}

enum HiveBox {
  items,
}
