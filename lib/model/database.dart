import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:qrstocker/entity/item.dart';

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
    if (_box.length >= 5) {
      return false;
    }
    if (item.isInBox) {
      await item.save();
    } else {
      await _box.add(item);
    }
    return true;
  }

  static Future delete(Item item) async {
    await item.delete();
  }

  static List<Item> debugData() {
    final item1 = Item();
    item1.title = 'QRStocker';
    item1.data = 'QRStocker';
    final item2 = Item();
    item2.title = 'Account';
    item2.data = 'Account';
    final item3 = Item();
    item3.title = 'Profile';
    item3.data = 'Profile';
    final item4 = Item();
    item4.title = 'Payment';
    item4.data = 'Payment';
    final item5 = Item();
    item5.title = 'Train';
    item5.data = 'Train';
    return [
      item1,
      item2,
      item3,
      item4,
      item5,
    ];
  }
}

enum HiveBox {
  items,
}
