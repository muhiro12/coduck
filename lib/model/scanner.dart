import 'package:barcode_scan/barcode_scan.dart';

class Scanner {
  static Future<String> scan() async {
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
    return result.rawContent;
  }
}
