import 'package:adaptive_dialog/adaptive_dialog.dart';
import 'package:coduck/entity/code.dart';
import 'package:coduck/model/ad_manager.dart';
import 'package:coduck/model/database.dart';
import 'package:coduck/model/scanner.dart';
import 'package:coduck/parameter/app_size.dart';
import 'package:coduck/scaffold/detail_scaffold.dart';
import 'package:coduck/scaffold/settings_scaffold.dart';
import 'package:coduck/widget/code_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class HomeScaffold extends StatelessWidget {
  HomeScaffold(this._title);

  final String _title;

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: Database.listenable(),
      builder: (context, Box<Code> box, __) {
        final List<Code> codes = box.values.toList();
        return Scaffold(
          appBar: AppBar(
            title: Text(
              _title,
            ),
            actions: <Widget>[
              IconButton(
                tooltip: 'Settings',
                icon: Icon(Icons.settings),
                onPressed: () => _presentSettings(context),
              )
            ],
          ),
          body: SafeArea(
            child: ListView(
              children: codes
                  .map(
                    (code) => Card(
                      margin: EdgeInsets.fromLTRB(
                        AppSize.spaceM,
                        AppSize.spaceS,
                        AppSize.spaceM,
                        AppSize.spaceS,
                      ),
                      child: ListTile(
                        title: Text(
                          code.title,
                        ),
                        trailing: CodeImage(code),
                        onTap: () => _pushDetail(
                          context,
                          codes.indexOf(code),
                        ),
                      ),
                    ),
                  )
                  .toList(),
            ),
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () => _add(context),
            tooltip: 'Add',
            child: Icon(Icons.add),
          ),
          bottomNavigationBar: SizedBox(
            height: kBottomNavigationBarHeight + AppSize.spaceL,
          ),
        );
      },
    );
  }

  void _add(BuildContext context) async {
    AdManager.hideBannerAd();
    final type = await showModalActionSheet<ScannerType>(
      context: context,
      actions: [
        SheetAction(
          label: 'Camera',
          key: ScannerType.camera,
        ),
        SheetAction(
          label: 'Image',
          key: ScannerType.image,
        ),
      ],
    );
    AdManager.showBannerAd();
    _scan(context, type);
  }

  void _scan(BuildContext context, ScannerType type) async {
    final result = await Scanner.scan(type);

    if (result == null) {
      return;
    }

    Database.save(result).then(
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

  void _pushDetail(
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
