import 'package:flutter/material.dart';
import 'package:send_stickers_example/src/core/view/sheet.dart';

import '../../settings/settings_view.dart';

///main screen 
class CoreScreen extends StatelessWidget {
  const CoreScreen({
    super.key,
  });

  static const routeName = '/';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Send sticker!'),
          actions: [
            IconButton(
              icon: const Icon(Icons.settings),
              onPressed: () {
                Navigator.restorablePushNamed(context, SettingsView.routeName);
              },
            ),
          ],
        ),
        backgroundColor: Color.fromRGBO(255, 255, 255, 0.5),
        body: Column(
          children: [
            Spacer(),
            Flexible(
              child: SheetWidget(),
            )
          ],
        ));
  }
}
