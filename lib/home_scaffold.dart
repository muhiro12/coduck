import 'package:barcode_scan/barcode_scan.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:qrstocker/database.dart';
import 'package:qrstocker/item.dart';

class HomeScaffold extends StatelessWidget {
  HomeScaffold(this._title);

  final String _title;

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: Database.listenable(),
      builder: (context, Box<Item> box, __) {
        final item = Item();
        item.title = 'title';
        item.qrText = 'qrcode';
        return Scaffold(
          appBar: AppBar(
            title: Text(_title),
          ),
          body: SafeArea(
            child: PageView(
              children: [item, item]
                  .map(
                    (item) => Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(item.title),
                        SizedBox(
                          width: 200,
                          child: Card(
                            child: Center(
                              child: QrImage(
                                data: item.qrText,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                  .toList(),
            ),
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: _scan,
            tooltip: 'Scan',
            child: Icon(Icons.photo_camera),
          ),
        );
      },
    );
  }

  void _scan() async {
    var result = await BarcodeScanner.scan();
    final qrText = result.rawContent;

    final item = Item();
    item.title = qrText;
    item.qrText = qrText;

    Database.save(item);
  }
}
