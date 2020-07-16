import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:qrstocker/item.dart';

class DetailScaffold extends StatefulWidget {
  DetailScaffold(
    this._items,
    this._initialPage,
  );

  final List<Item> _items;
  final int _initialPage;

  @override
  State<StatefulWidget> createState() {
    return _DetailScaffoldState(
      PageController(
        initialPage: _initialPage,
      ),
    );
  }
}

class _DetailScaffoldState extends State<DetailScaffold> {
  _DetailScaffoldState(this._pageController);

  final PageController _pageController;
  Item _item;

  @override
  void initState() {
    super.initState();
    _item = widget._items[widget._initialPage];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          _item.title,
        ),
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
              Text(
                _item.qrText,
              ),
              Expanded(
                child: PageView(
                  controller: _pageController,
                  children: widget._items
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
                  onPageChanged: (page) => _updateItem(page),
                ),
              ),
              Text(
                _item.note,
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _updateItem(int page) {
    setState(() {
      _item = widget._items[page];
    });
  }
}
