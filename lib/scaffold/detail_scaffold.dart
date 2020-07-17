import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:qrstocker/entity/item.dart';
import 'package:qrstocker/model/database.dart';

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
        final item =
            items.isNotEmpty ? items[min(page, items.length - 1)] : Item();
        return Scaffold(
          appBar: AppBar(
            title: Text('Detail'),
            actions: <Widget>[
              IconButton(
                icon: Icon(Icons.delete),
                onPressed: () => showDeleteDialog(
                  context,
                  item,
                  willPop: items.length <= 1,
                ),
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
                  Text(item.note),
                  Expanded(
                    child: PageView(
                      controller: _pageController,
                      children: items
                          .map(
                            (item) => Center(
                              child: Card(
                                color: Colors.white,
                                child: Container(
                                  constraints: BoxConstraints(
                                    maxWidth: 200,
                                    maxHeight: 200,
                                  ),
                                  child: QrImage(
                                    data: item.data,
                                  ),
                                ),
                              ),
                            ),
                          )
                          .toList(),
                      onPageChanged: _updatePage,
                    ),
                  ),
                  Text(item.data),
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

  void showDeleteDialog(
    BuildContext context,
    Item item, {
    bool willPop = false,
  }) {
    showDialog(
      context: context,
      child: CupertinoAlertDialog(
        title: Text('Are you sure you want to delete this item?'),
        actions: <Widget>[
          FlatButton(
            child: Text(
              'Cancel',
              style: TextStyle(
                color: Colors.blue,
                fontWeight: FontWeight.bold,
              ),
            ),
            onPressed: () => Navigator.pop(context),
          ),
          FlatButton(
            child: Text(
              'Delete',
              style: TextStyle(
                color: Colors.red,
              ),
            ),
            onPressed: () => willPop ? _deleteAndPop(item) : _delete(item),
          ),
        ],
      ),
    );
  }

  void _delete(Item item) {
    Database.delete(item);
  }

  void _deleteAndPop(Item item) {
    Navigator.pop(context);
    _delete(item);
  }
}
