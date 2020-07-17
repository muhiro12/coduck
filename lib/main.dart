import 'package:flutter/material.dart';
import 'package:qrstocker/model/database.dart';
import 'package:qrstocker/scaffold/home_scaffold.dart';

void main() async {
  await Database.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    const primaryColor = Colors.orange;
    return MaterialApp(
      title: 'QR Stocker',
      theme: ThemeData(
        primarySwatch: primaryColor,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      darkTheme: ThemeData(
        primarySwatch: primaryColor,
        accentColor: primaryColor,
        brightness: Brightness.dark,
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
  @override
  Widget build(BuildContext context) {
    return HomeScaffold(widget.title);
  }
}
