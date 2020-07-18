import 'package:coduck/entity/code.dart';
import 'package:coduck/model/database.dart';
import 'package:coduck/parameter/app_color.dart';
import 'package:coduck/parameter/app_size.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class EditScaffold extends StatelessWidget {
  EditScaffold(this._code)
      : _titleController = TextEditingController(
          text: _code.title,
        ),
        _noteController = TextEditingController(
          text: _code.note,
        );

  final Code _code;
  final TextEditingController _titleController;
  final TextEditingController _noteController;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: FocusScope.of(context).unfocus,
      child: Scaffold(
        appBar: AppBar(
          title: Text(_code.title),
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
              AppSize.spaceL,
              AppSize.spaceM,
              AppSize.spaceL,
              AppSize.spaceM,
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
        title: Text('Are you sure you want to delete this code?'),
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
                color: AppColor.red,
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
      _code
        ..title = _titleController.text
        ..note = _noteController.text,
    );
  }

  void _delete() {
    Database.delete(_code);
  }

  static void push(
    BuildContext context,
    Code code,
  ) {
    Navigator.push(
      context,
      PageRouteBuilder(
        pageBuilder: (_, __, ___) => EditScaffold(code),
      ),
    );
  }
}
