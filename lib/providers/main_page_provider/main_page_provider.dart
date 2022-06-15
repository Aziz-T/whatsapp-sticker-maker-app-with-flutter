

import 'package:flutter/cupertino.dart';

import '../../pages/home_page/home_page.dart';
import '../../pages/settings_page/settings_page.dart';
import '../../pages/stickers_page/stickers_page.dart';

class MainPageProvider extends ChangeNotifier{

  int _currentIndex=0;
  get currentIndex => _currentIndex;

  Widget _currentPage = HomePage();
  get currentPage => _currentPage;


  static const List<Widget> _widgetOptions = <Widget>[
    HomePage(),
    StickersPage(),
    SettingsPage()
  ];

  void onItemTapped(int index) {

      _currentIndex = index;
      _currentPage = _widgetOptions[_currentIndex];
      notifyListeners();
  }



}