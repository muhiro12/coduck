import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:package_info/package_info.dart';

class SettingsScaffold extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Settings'),
        leading: IconButton(
          icon: Icon(Icons.close),
          onPressed: () => Navigator.pop(context),
        ),
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

  void _showAbout(BuildContext context) async {
    final packageInfo = await PackageInfo.fromPlatform();
    final version = 'Version: ' + packageInfo.version;
    showAboutDialog(
      context: context,
      applicationVersion: version,
    );
  }

  static void present(BuildContext context) {
    showCupertinoModalPopup(
      context: context,
      builder: (_) => SettingsScaffold(),
    );
  }
}
