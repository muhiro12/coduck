import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:qrstocker/item.dart';

class DetailScaffold extends StatelessWidget {
  DetailScaffold(
    this._items,
    this._pageController,
  );

  final List<Item> _items;
  final PageController _pageController;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Detail',
        ),
      ),
      body: SafeArea(
        child: PageView(
          controller: _pageController,
          children: _items
              .map(
                (item) => Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      item.title,
                    ),
                    SizedBox(
                      width: 200,
                      height: 200,
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
    );
  }
}
