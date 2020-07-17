import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:qrstocker/entity/item.dart';
import 'package:qrstocker/model/database.dart';

class EditScaffold extends StatelessWidget {
  EditScaffold(this._item)
      : _noteController = TextEditingController(
          text: _item.note,
        ),
        _dataController = TextEditingController(
          text: _item.data,
        );

  final Item _item;
  final TextEditingController _noteController;
  final TextEditingController _dataController;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              TextField(
                controller: _noteController,
                textAlign: TextAlign.center,
              ),
              Expanded(
                child: Center(
                  child: Card(
                    color: Colors.white,
                    child: Container(
                      constraints: BoxConstraints(
                        maxWidth: 200,
                        maxHeight: 200,
                      ),
                      child: QrImage(
                        data: _item.data,
                      ),
                    ),
                  ),
                ),
              ),
              Text(_item.data),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        tooltip: 'Done',
        child: Icon(Icons.done),
        onPressed: () {
          _save(_item);
          Navigator.popUntil(
            context,
            (route) => route.isFirst,
          );
        },
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
              _delete(_item);
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

  void _save(Item item) {
    Database.save(
      item
        ..note = _noteController.text
        ..data = _dataController.text,
    );
  }

  void _delete(Item item) {
    Database.delete(item);
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
