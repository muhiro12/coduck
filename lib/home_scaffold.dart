import 'package:barcode_scan/barcode_scan.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:qrstocker/database.dart';
import 'package:qrstocker/detail_scaffold.dart';
import 'package:qrstocker/item.dart';

class HomeScaffold extends StatelessWidget {
  HomeScaffold(this._title);

  final String _title;

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: Database.listenable(),
      builder: (context, Box<Item> box, __) {
        return Scaffold(
          appBar: AppBar(
            title: Text(
              _title,
            ),
          ),
          body: SafeArea(
            child: ListView(
              children: box.values
                  .map(
                    (item) => Card(
                      child: ListTile(
                        title: Text(
                          item.title,
                        ),
                        trailing: QrImage(
                          data: item.qrText,
                        ),
                        onTap: () => pushDetail(
                          context,
                          item,
                          box.values.toList(),
                        ),
                      ),
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

  void pushDetail(
    BuildContext context,
    Item item,
    List<Item> items,
  ) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => DetailScaffold(
          items,
          PageController(
            initialPage: items.indexOf(item),
          ),
        ),
      ),
    );
  }
}
