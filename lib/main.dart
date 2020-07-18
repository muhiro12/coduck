import 'package:coduck/model/ad_manager.dart';
import 'package:coduck/model/database.dart';
import 'package:coduck/parameter/app_theme.dart';
import 'package:coduck/scaffold/home_scaffold.dart';
import 'package:firebase_admob/firebase_admob.dart';
import 'package:flutter/material.dart';

void main() async {
  await Database.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Coduck',
      theme: AppTheme.light(),
      darkTheme: AppTheme.dark(),
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
  BannerAd _bannerAd;

  @override
  void initState() {
    super.initState();
    _initAdMob();
    _bannerAd = BannerAd(
      adUnitId: AdManager.bannerAdUnitId,
      size: AdSize.fullBanner,
    );
    _loadBannerAd();
  }

  @override
  void dispose() {
    _bannerAd?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return HomeScaffold(widget.title);
  }

  Future _initAdMob() {
    return FirebaseAdMob.instance.initialize(
      appId: AdManager.appId,
    );
  }

  void _loadBannerAd() {
    _bannerAd
      ..load()
      ..show(
        anchorType: AnchorType.bottom,
      );
  }
}
