import 'package:flutter/material.dart';
import 'package:app/screens/home_screen/components/home_screen.dart';

class Nav extends StatefulWidget {
  const Nav({Key? key}) :  super(key: key);

  @override
  _NavState createState() => _NavState();
}

class _NavState extends State<Nav> {
  int _selectedIndex = 0;
  static List<Widget> _widgetOptions = <Widget>[
    Home(),
    Text("Hola"),
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
            label: 'Inicio',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: 'Inicio'
          ),
        ],
        // _onItemTapped will receive the index of the selected item in the row
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}