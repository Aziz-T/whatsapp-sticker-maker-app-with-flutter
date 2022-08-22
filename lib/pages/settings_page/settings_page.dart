import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_share/flutter_share.dart';
import 'package:in_app_review/in_app_review.dart';
import 'package:wpstickermaker/core/functions.dart';
import 'package:wpstickermaker/values/styles/TextStyles.dart';

import '../../widgets/app_bar/my_app_bar.dart';

enum Availability { loading, available, unavailable }

class SettingsPage extends StatefulWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  final InAppReview _inAppReview = InAppReview.instance;

  String _appStoreId = 'com.aven.wpstickermaker';

  Availability _availability = Availability.loading;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance?.addPostFrameCallback((timeStamp) {
      setAvailability();
    });
  }

  Future<void> setAvailability() async {
    WidgetsBinding.instance!.addPostFrameCallback((_) async {
      try {
        final isAvailable = await _inAppReview.isAvailable();
        p("isAvailable", isAvailable);
        setState(() {
          // This plugin cannot be tested on Android by installing your app
          // locally. See https://github.com/britannio/in_app_review#testing for
          // more information.
          _availability = isAvailable && Platform.isAndroid
              ? Availability.available
              : Availability.unavailable;
        });
      } catch (e) {
        p("catch", _availability);
        setState(() => _availability = Availability.unavailable);
      }
    });
  }

  Future<void> _requestReview() => _inAppReview.requestReview();

  Future<void> _openStoreListing() => _inAppReview.openStoreListing(
        appStoreId: _appStoreId,
      );
  Future<void> share() async {
    await FlutterShare.share(
        title: 'Whattsapp Sticker Maker App',
        text: 'Whattsapp Sticker Maker App',
        linkUrl:
            'https://play.google.com/store/apps/details?id=com.aven.wpstickermaker',
        chooserTitle: 'Whattsapp Sticker Maker App');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(title: 'Settings'),
      body: Column(
        children: [
          Divider(),
          buildSettingsItem(Icons.share, "Share App", () {
            share();
          }),
          Divider(),
          buildSettingsItem(Icons.star, "Rate App", () {
            if (_availability == Availability.available) {
              _requestReview();
              p("AVAILABLE", "PRESS BUTTON");
            }
          }),
          Divider(),
          // buildSettingsItem(
          //   Icons.monetization_on,
          //   "Buy Premium",
          //   () {
          //
          //   },
          //   endTitle: "14.99 USD",
          // ),
          // Divider(),
        ],
      ),
    );
  }

  InkWell buildSettingsItem(IconData icon, String title, VoidCallback onTap,
      {String? endTitle}) {
    return InkWell(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.all(8),
        child: Row(children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Icon(icon),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              title,
              style:
                 TextStyles.mcLarenStyle.copyWith(fontWeight: FontWeight.bold),
            ),
          ),
          Spacer(),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              endTitle ?? "",
              style:
              TextStyles.mcLarenStyle.copyWith(fontWeight: FontWeight.bold),
            ),
          )
        ]),
      ),
    );
  }
}
