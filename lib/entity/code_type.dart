import 'package:barcode_scan/barcode_scan.dart';

enum CodeType {
  unknown,
  qr,
}

extension CodeTypeExtension on CodeType {
  int value() {
    return index;
  }

  static CodeType init(BarcodeFormat input) {
    switch (input) {
      case BarcodeFormat.qr:
        return CodeType.qr;
      default:
        return CodeType.unknown;
    }
  }
}
