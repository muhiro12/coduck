import 'package:barcode_widget/barcode_widget.dart';
import 'package:coduck/entity/code.dart';
import 'package:coduck/entity/code_type.dart';
import 'package:coduck/parameter/app_color.dart';
import 'package:coduck/parameter/app_size.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CodeImage extends StatelessWidget {
  CodeImage(this._code);

  final Code _code;

  @override
  Widget build(BuildContext context) {
    final isQR = _code.type == CodeType.qr.value();
    return FittedBox(
      child: Card(
        margin: EdgeInsets.all(AppSize.spaceL),
        color: AppColor.white,
        child: BarcodeWidget(
          data: _code.data,
          barcode: Barcode.qrCode(),
          drawText: false,
          width: AppSize.codeImage,
          height: isQR ? AppSize.codeImage : null,
          padding: EdgeInsets.all(AppSize.spaceM),
        ),
      ),
    );
  }
}
