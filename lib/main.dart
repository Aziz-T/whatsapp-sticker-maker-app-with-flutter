import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wpstickermaker/providers/main_page_provider/main_page_provider.dart';

import 'app.dart';

void main() {
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (context) => MainPageProvider()),
  ], child: const App()));
}
