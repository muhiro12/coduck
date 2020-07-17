import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:qrstocker/entity/item.dart';
import 'package:qrstocker/model/database.dart';

class EditScaffold extends StatelessWidget {
  EditScaffold(this._item)
      : _noteController = TextEditingController(
          text: _item.note,
        );

  final Item _item;
  final TextEditingController _noteController;

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
              SelectableText(_item.data),
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
              TextField(
                controller: _noteController,
                textAlign: TextAlign.center,
                maxLines: 5,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                ),
              ),
            ],
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
      _item..note = _noteController.text,
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
