import 'package:coduck/entity/code.dart';
import 'package:coduck/entity/code_type.dart';
import 'package:coduck/parameter/app_rule.dart';
import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

class Database {
  static String _key = HiveBox.codes.toString();

  static Box<Code> _box;

  static Future init() async {
    await Hive.initFlutter();
    Hive.registerAdapter(CodeAdapter());
    _box = await Hive.openBox<Code>(_key);
  }

  static ValueListenable<Box<Code>> listenable() {
    return _box.listenable();
  }

  static Future<bool> save(Code code) async {
    if (_box.length >= AppRule.codesCountLimit) {
      return false;
    }
    if (code.isInBox) {
      await code.save();
    } else {
      await _box.add(code);
    }
    return true;
  }

  static Future delete(Code code) async {
    await code.delete();
  }

  static List<Code> debugData() {
    final qr = CodeType.qr.value();
    final code1 = Code(qr, 'Coduck');
    final code2 = Code(qr, 'Account');
    final code3 = Code(qr, 'Profile');
    final code4 = Code(qr, 'Payment');
    final code5 = Code(qr, 'Train');
    return [
      code1,
      code2,
      code3,
      code4,
      code5,
    ];
  }
}

enum HiveBox {
  codes,
}
