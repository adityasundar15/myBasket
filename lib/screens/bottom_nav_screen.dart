import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import './profile_screen.dart';
import '../shoppingList/shoppinglist_page.dart';
import './stock_screen.dart';

class TabScreen extends StatefulWidget {
  const TabScreen({super.key});

  @override
  State<TabScreen> createState() => _TabScreenState();
}

class _TabScreenState extends State<TabScreen> {
  final List<Map<String, Object>> _pages = [
    {'page': StockScreen(), 'title': 'Current Stock'},
    {'page': ShoppingList(), 'title': 'Shopping List'},
    {'page': ProfileScreen(), 'title': 'Profile'}
  ];
  int _selectedPageIndex = 0;

  void _setPage(int index) {
    setState(() {
      _selectedPageIndex = index;
    });
  }

  void changeScreen() {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _selectedPageIndex != 1
          ? AppBar(
              systemOverlayStyle: const SystemUiOverlayStyle(
                statusBarColor: Colors.black,
                statusBarIconBrightness: Brightness.dark,
                statusBarBrightness: Brightness.light,
              ),
              backgroundColor: Colors.transparent,
              elevation: 0.0,
              centerTitle: false,
              title: Text(
                _pages[_selectedPageIndex]['title'] as String,
                style: const TextStyle(fontSize: 28),
              ),
              foregroundColor: Theme.of(context).primaryColor,
            )
          : null,
      body: _pages[_selectedPageIndex]['page'] as Widget,
      bottomNavigationBar: BottomNavigationBar(
          backgroundColor: Colors.white,
          // selectedItemColor: Theme.of(context).primaryColor,
          currentIndex: _selectedPageIndex,
          onTap: _setPage,
          items: const [
            BottomNavigationBarItem(
                icon: Icon(Icons.shopping_cart), label: 'Stock'),
            BottomNavigationBarItem(
                icon: Icon(Icons.shopping_basket), label: 'Shopping'),
            BottomNavigationBarItem(
                icon: Icon(CupertinoIcons.person_fill), label: 'Profile')
          ]),
      // floatingActionButton: fabs[_selectedPageIndex],
    );
  }
}
