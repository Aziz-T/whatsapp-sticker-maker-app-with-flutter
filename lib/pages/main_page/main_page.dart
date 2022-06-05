import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wpstickermaker/providers/main_page_provider/main_page_provider.dart';
import '../../widgets/bottom_nav_bar/bottom_nav_bar.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  Widget build(BuildContext context) {
    return Consumer<MainPageProvider>(
      builder: (context, state, _) {
        return Scaffold(
        body: state.currentPage,
        bottomNavigationBar: BottomNavBar(),
        );
      }
    );
  }
}
