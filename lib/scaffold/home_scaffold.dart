import 'package:coduck/entity/item.dart';
import 'package:coduck/model/database.dart';
import 'package:coduck/model/scanner.dart';
import 'package:coduck/scaffold/detail_scaffold.dart';
import 'package:coduck/scaffold/settings_scaffold.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:qr_flutter/qr_flutter.dart';

class HomeScaffold extends StatelessWidget {
  HomeScaffold(this._title);

  final String _title;

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: Database.listenable(),
      builder: (context, Box<Item> box, __) {
        final List<Item> items = box.values.toList();
        return Scaffold(
          appBar: AppBar(
            title: Text(
              _title,
            ),
            actions: <Widget>[
              IconButton(
                icon: Icon(Icons.settings),
                onPressed: () => _presentSettings(context),
              )
            ],
          ),
          body: SafeArea(
            child: ListView(
              children: items
                  .map(
                    (item) => Card(
                      child: ListTile(
                        title: Text(
                          item.title,
                        ),
                        trailing: Card(
                          color: Colors.white,
                          child: QrImage(
                            data: item.data,
                          ),
                        ),
                        onTap: () => pushDetail(
                          context,
                          items.indexOf(item),
                        ),
                      ),
                    ),
                  )
                  .toList(),
            ),
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () => _scan(context),
            tooltip: 'Scan',
            child: Icon(Icons.camera),
          ),
        );
      },
    );
  }

  void _scan(BuildContext context) async {
    final data = await Scanner.scan();

    if (data == null) {
      return;
    }

    final item = Item();
    item.title = data;
    item.data = data;

    Database.save(item).then(
      (success) {
        if (success) {
          return;
        }
        showDialog(
          context: context,
          child: AlertDialog(
            title: Text('Sorry, the limit is 5 cards.'),
          ),
        );
      },
    );
  }

  void pushDetail(
    BuildContext context,
    int index,
  ) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => DetailScaffold(index),
      ),
    );
  }

  void _presentSettings(BuildContext context) {
    SettingsScaffold.present(context);
  }
}
