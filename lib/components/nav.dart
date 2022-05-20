import 'package:flutter/material.dart';
import 'package:app/screens/home_screen/components/home_screen.dart';
import 'package:app/screens/dictionary/components/dictionary.dart';
import 'package:app/screens/favorites/components/favorites.dart';

class Nav extends StatefulWidget {
  const Nav({Key? key}) :  super(key: key);

  @override
  _NavState createState() => _NavState();
}

class _NavState extends State<Nav> {
  int _selectedIndex = 0;
  static const List<Widget> _widgetOptions = <Widget>[
    Home(),
    Dictionary(),
    Favorites(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: _widgetOptions[_selectedIndex]),
      bottomNavigationBar: BottomNavigationBar(
        // items is a list of BottomNavigationBarItem
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home_filled),
            label: 'Palabra del Día',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.book),
            label: 'Diccionario'
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.favorite),
              label: 'Favoritos'
          )
        ],
        // _onItemTapped will receive the index of the selected item in the row
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}