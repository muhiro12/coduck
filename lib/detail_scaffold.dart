import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:qrstocker/database.dart';
import 'package:qrstocker/item.dart';

class DetailScaffold extends StatefulWidget {
  DetailScaffold(this._initialPage);

  final int _initialPage;

  @override
  State<StatefulWidget> createState() {
    return _DetailScaffoldState(_initialPage);
  }
}

class _DetailScaffoldState extends State<DetailScaffold> {
  _DetailScaffoldState(int initialPage)
      : _pageController = PageController(initialPage: initialPage);

  final PageController _pageController;

  int page;

  @override
  void initState() {
    super.initState();
    page = widget._initialPage;
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: Database.listenable(),
      builder: (context, Box<Item> box, _) {
        final items = box.values.toList();
        if (items.isEmpty) {
          Navigator.pop(context);
          return Container();
        }
        final item = items[min(page, items.length - 1)];
        return Scaffold(
          appBar: AppBar(
            title: Text(item.title),
            actions: <Widget>[
              IconButton(
                icon: Icon(Icons.delete),
                onPressed: () => _delete(item),
              )
            ],
          ),
          body: SafeArea(
            child: Container(
              padding: EdgeInsets.only(
                top: 40,
                bottom: 40,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(item.qrText),
                  Expanded(
                    child: PageView(
                      controller: _pageController,
                      children: items
                          .map(
                            (item) => Center(
                              child: Card(
                                child: Container(
                                  constraints: BoxConstraints(
                                    maxWidth: 200,
                                    maxHeight: 200,
                                  ),
                                  child: QrImage(
                                    data: item.qrText,
                                  ),
                                ),
                              ),
                            ),
                          )
                          .toList(),
                      onPageChanged: _updatePage,
                    ),
                  ),
                  Text(item.note),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  void _updatePage(int page) {
    setState(() {
      this.page = page;
    });
  }

  void _delete(Item item) {
    Database.delete(item);
  }
}
