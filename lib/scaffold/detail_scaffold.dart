import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:qrstocker/entity/item.dart';
import 'package:qrstocker/model/database.dart';
import 'package:qrstocker/scaffold/edit_scaffold.dart';

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
        final item = items[page];
        return Scaffold(
          appBar: AppBar(
            title: Text(item.title),
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
          floatingActionButton: FloatingActionButton(
            onPressed: () => _pushEdit(
              context,
              item,
            ),
            tooltip: 'Edit',
            child: Icon(Icons.edit),
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

  void _pushEdit(
    BuildContext context,
    Item item,
  ) {
    EditScaffold.push(
      context,
      item,
    );
  }
}
