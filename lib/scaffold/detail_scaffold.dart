import 'package:coduck/entity/code.dart';
import 'package:coduck/model/database.dart';
import 'package:coduck/parameter/app_size.dart';
import 'package:coduck/scaffold/edit_scaffold.dart';
import 'package:coduck/widget/code_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

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
      builder: (context, Box<Code> box, _) {
        final codes = box.values.toList();
        final code = codes[page];
        return Scaffold(
          appBar: AppBar(
            title: Text(code.title),
          ),
          body: SafeArea(
            child: Container(
              padding: EdgeInsets.fromLTRB(
                AppSize.spaceL,
                AppSize.spaceM,
                AppSize.spaceL,
                AppSize.spaceM,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Flexible(
                    child: TextField(
                      controller: TextEditingController(
                        text: code.note,
                      ),
                      readOnly: true,
                      maxLines: 5,
                      decoration: InputDecoration(
                        labelText: 'Note',
                        floatingLabelBehavior: FloatingLabelBehavior.always,
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                  Expanded(
                    child: PageView(
                      controller: _pageController,
                      children: codes
                          .map(
                            (code) => Center(
                              child: CodeImage(code),
                            ),
                          )
                          .toList(),
                      onPageChanged: _updatePage,
                    ),
                  ),
                  Flexible(
                    child: TextField(
                      controller: TextEditingController(
                        text: code.data,
                      ),
                      readOnly: true,
                      maxLines: 5,
                      decoration: InputDecoration(
                        labelText: 'Data',
                        floatingLabelBehavior: FloatingLabelBehavior.always,
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () => _pushEdit(
              context,
              code,
            ),
            tooltip: 'Edit',
            child: Icon(Icons.edit),
          ),
          bottomNavigationBar: SizedBox(
            height: kBottomNavigationBarHeight + AppSize.spaceL,
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
    Code code,
  ) {
    EditScaffold.push(
      context,
      code,
    );
  }
}
