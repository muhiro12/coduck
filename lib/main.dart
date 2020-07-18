import 'package:coduck/model/database.dart';
import 'package:coduck/scaffold/home_scaffold.dart';
import 'package:flutter/material.dart';

void main() async {
  await Database.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    const primaryColor = Colors.orange;
    return MaterialApp(
      title: 'Coduck',
      theme: ThemeData(
        primarySwatch: primaryColor,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      darkTheme: ThemeData(
        primarySwatch: primaryColor,
        accentColor: primaryColor,
        brightness: Brightness.dark,
      ),
      home: MyHomePage(title: 'Coduck'),
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
