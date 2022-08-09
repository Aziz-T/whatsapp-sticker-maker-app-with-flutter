import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wpstickermaker/core/storage_manager.dart';
import 'package:wpstickermaker/providers/home_page_provider/home_page_provider.dart';
import 'package:wpstickermaker/providers/image_editing_provider/image_editing_provider.dart';
import 'package:wpstickermaker/providers/main_page_provider/main_page_provider.dart';

import 'app.dart';
import 'deneme.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await StorageManager.initPrefs();
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (context) => MainPageProvider()),
    ChangeNotifierProvider(create: (context) => HomePageProvider()),
    ChangeNotifierProvider(create: (context) => ImageEditProvider()),
  ], child: const App()));
}
///  /data/user/0/com.aven.wpstickermaker/app_flutter/sticker_packs.json