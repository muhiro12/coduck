import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:qrstocker/entity/item.dart';
import 'package:qrstocker/model/database.dart';

class EditScaffold extends StatelessWidget {
  EditScaffold(this._item)
      : _titleController = TextEditingController(
          text: _item.title,
        ),
        _noteController = TextEditingController(
          text: _item.note,
        );

  final Item _item;
  final TextEditingController _titleController;
  final TextEditingController _noteController;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: FocusScope.of(context).unfocus,
      child: Scaffold(
        appBar: AppBar(
          title: Text(_item.title),
          leading: IconButton(
            icon: Icon(Icons.close),
            onPressed: () => Navigator.pop(context),
          ),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.delete),
              onPressed: () => _showDeleteDialog(context),
            ),
          ],
        ),
        body: SafeArea(
          child: Container(
            padding: EdgeInsets.fromLTRB(
              40,
              20,
              40,
              20,
            ),
            child: Form(
              child: ListView(
                children: <Widget>[
                  FormField(
                    builder: (_) => TextField(
                      controller: _titleController,
                      decoration: InputDecoration(
                        labelText: 'Title',
                      ),
                    ),
                  ),
                  FormField(
                    builder: (_) => TextField(
                      controller: _noteController,
                      maxLines: 5,
                      decoration: InputDecoration(
                        labelText: 'Note',
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          tooltip: 'Done',
          child: Icon(Icons.done),
          onPressed: () {
            _save();
            Navigator.popUntil(
              context,
              (route) => route.isFirst,
            );
          },
        ),
      ),
    );
  }

  void _showDeleteDialog(BuildContext context) {
    showDialog(
      context: context,
      child: CupertinoAlertDialog(
        title: Text('Are you sure you want to delete this item?'),
        actions: <Widget>[
          FlatButton(
            child: Text(
              'Cancel',
              style: TextStyle(
                color: Theme.of(context).primaryColor,
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
            onPressed: () {
              _delete();
              Navigator.popUntil(
                context,
                (route) => route.isFirst,
              );
            },
          ),
        ],
      ),
    );
  }

  void _save() {
    Database.save(
      _item
        ..title = _titleController.text
        ..note = _noteController.text,
    );
  }

  void _delete() {
    Database.delete(_item);
  }

  static void push(
    BuildContext context,
    Item item,
  ) {
    Navigator.push(
      context,
      PageRouteBuilder(
        pageBuilder: (_, __, ___) => EditScaffold(item),
      ),
    );
  }
}
