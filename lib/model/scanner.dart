import 'package:barcode_scan/barcode_scan.dart';
import 'package:coduck/entity/code.dart';
import 'package:coduck/entity/code_type.dart';

class Scanner {
  static Future<Code> scan() async {
    final result = await BarcodeScanner.scan(
      options: ScanOptions(
        restrictFormat: [
          BarcodeFormat.qr,
        ],
      ),
    );
    if (result.type != ResultType.Barcode) {
      return null;
    }
    final type = CodeTypeExtension.init(result.format);
    return Code(
      type.value(),
      result.rawContent,
    );
  }
}
