import 'dart:io';

import 'package:barcode_scan/barcode_scan.dart';
import 'package:coduck/entity/code.dart';
import 'package:coduck/entity/code_type.dart';
import 'package:flutter_qr_reader/flutter_qr_reader.dart';
import 'package:image_picker/image_picker.dart';

enum ScannerType {
  camera,
  image,
}

class Scanner {
  static Future<Code> scan(ScannerType type) async {
    switch (type) {
      case ScannerType.camera:
        return _scanFromCamera();
      case ScannerType.image:
        return _scanFromImage();
      default:
        return null;
    }
  }

  static Future<Code> _scanFromCamera() async {
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

  static Future<Code> _scanFromImage() async {
    final pickedFile = await ImagePicker().getImage(
      source: ImageSource.gallery,
    );
    if (pickedFile == null) {
      return null;
    }
    final data = await FlutterQrReader.imgScan(
      File(pickedFile.path),
    );
    if (data == null) {
      return null;
    }
    return Code(
      CodeType.qr.value(),
      data,
    );
  }
}
