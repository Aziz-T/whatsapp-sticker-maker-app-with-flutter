import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wpstickermaker/providers/main_page_provider/main_page_provider.dart';
import 'package:wpstickermaker/values/colors/my_colors.dart';

class BottomNavBar extends StatefulWidget {
  const BottomNavBar({Key? key}) : super(key: key);

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {

  static const TextStyle optionStyle =
  TextStyle(fontSize: 30, fontWeight: FontWeight.bold);


  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.image),
          label: 'Stickers',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.settings_sharp),
          label: 'Settings',
        ),
      ],
      currentIndex: context.watch<MainPageProvider>().currentIndex,
      selectedItemColor:  MyColors.violet,
      onTap: (index){
        context.read<MainPageProvider>().onItemTapped(index);
      },
    );
  }
}
