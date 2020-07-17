import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SettingsScaffold extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Settings'),
      ),
      body: SafeArea(
        child: ListView(
          children: <Widget>[
            ListTile(
              title: Text('About'),
              trailing: Icon(Icons.arrow_forward_ios),
              dense: true,
              onTap: () => _showAbout(context),
            ),
          ],
        ),
      ),
    );
  }

  void _showAbout(BuildContext context) {
    showAboutDialog(context: context);
  }

  static void present(BuildContext context) {
    showCupertinoModalPopup(
      context: context,
      builder: (_) => SettingsScaffold(),
    );
  }
}
