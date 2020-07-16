import 'package:barcode_scan/barcode_scan.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:qrstocker/database.dart';
import 'package:qrstocker/item.dart';

void main() async {
  await Database.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'QR Stocker',
      theme: ThemeData(
        primarySwatch: Colors.teal,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'QR Stocker'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  void _scan() async {
    var result = await BarcodeScanner.scan();
    final qrText = result.rawContent;

    final item = Item();
    item.title = qrText;
    item.qrText = qrText;
    Database.save(item);
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: Database.listenable(),
      builder: (context, Box<Item> box, __) {
        return Scaffold(
          appBar: AppBar(
            title: Text(widget.title),
          ),
          body: SafeArea(
            child: PageView(
              children: box.values
                  .map(
                    (item) => Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(item.title),
                        SizedBox(
                          width: 300,
                          height: 300,
                          child: Card(
                            child: Center(
                              child: Text(
                                item.qrText,
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
}
