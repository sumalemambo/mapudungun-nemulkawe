import 'package:flutter/material.dart';

import 'package:app/screens/home/main.dart';
import 'package:app/screens/dictionary/main.dart';
import 'package:app/screens/favorites/main.dart';


class Nav extends StatefulWidget {
  const Nav({Key? key}) :  super(key: key);

  @override
  _NavState createState() => _NavState();
}

class _NavState extends State<Nav> {
  int _selectedIndex = 0;

  late PageController pageController;

  static const List<Widget> _widgetOptions = <Widget>[
    HomeScreen(),
    DictionaryScreen(),
    FavoritesScreen(),
  ];

  @override
  void initState() {
    super.initState();
    pageController = PageController();
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    pageController.jumpToPage(index);
  }

  void onPageChanged(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: WillPopScope(
          // Función para redirigir el botón de regreso
          onWillPop: () async {
            if (_selectedIndex == 0) {
              return true;
            }
            else {
              setState(() {
                _onItemTapped(0);
              });
              return false;
            }
          },
          child: PageView(
            children: _widgetOptions,
            controller: pageController,
            onPageChanged: onPageChanged,
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: [Colors.blue, Colors.green, Colors.red][_selectedIndex],
        // items is a list of BottomNavigationBarItem
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home_filled),
            label: 'Palabra del Día',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.book),
            label: 'Diccionario',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: 'Favoritos',
          ),
        ],
        // _onItemTapped will receive the index of the selected item in the row
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}

class CustomShapeBorder extends ContinuousRectangleBorder {
  @override
  Path getOuterPath(Rect rect, {TextDirection? textDirection}) {

    const double innerCircleRadius = 150.0;

    Path path = Path();
    path.lineTo(0, rect.height);
    path.quadraticBezierTo(rect.width / 2 - (innerCircleRadius / 2) - 30, rect.height + 15, rect.width / 2 - 75, rect.height + 50);
    path.cubicTo(
        rect.width / 2 - 40, rect.height + innerCircleRadius - 40,
        rect.width / 2 + 40, rect.height + innerCircleRadius - 40,
        rect.width / 2 + 75, rect.height + 50
    );
    path.quadraticBezierTo(rect.width / 2 + (innerCircleRadius / 2) + 30, rect.height + 15, rect.width, rect.height);
    path.lineTo(rect.width, 0.0);
    path.close();

    return path;
  }
}