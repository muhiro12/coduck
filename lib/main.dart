import 'package:barcode_scan/barcode_scan.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:qrstocker/item.dart';
import 'package:qrstocker/repository.dart';

void main() async {
  await Database.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
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
  String _result = '';

  void _scan() async {
    var result = await BarcodeScanner.scan();
    setState(() {
      _result = result.rawContent;

      final item = Item();
      item.title = _result;
      item.qrText = _result;
      Database.save(item);
    });
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
          body: Center(
            child: SizedBox(
              width: 300,
              height: 300,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: <Widget>[
                  Text(
                    'Data',
                  ),
                ]..addAll(
                    box.values
                        .map(
                          (item) => SizedBox(
                            width: 200,
                            child: Card(
                              child: Center(
                                child: Text(
                                  item.qrText,
                                ),
                              ),
                            ),
                          ),
                        )
                        .toList(),
                  ),
              ),
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
