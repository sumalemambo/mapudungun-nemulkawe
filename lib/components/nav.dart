import 'package:flutter/material.dart';
import 'package:app/screens/home_screen/components/home_screen.dart';
import 'package:app/screens/dictionary/components/dictionary.dart';
import 'package:app/screens/favorites/components/favorites.dart';
import 'package:app/screens/test/components/test.dart';

class Nav extends StatefulWidget {
  const Nav({Key? key}) :  super(key: key);

  @override
  _NavState createState() => _NavState();
}

class _NavState extends State<Nav> {
  int _selectedIndex = 0;

  static const List<Widget> _widgetOptions = <Widget>[
    Home(),
    Favorites(),
    Test(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      /*
      appBar: AppBar(
        title: Image.asset('assets/azum6.png', fit: BoxFit.cover),
        backgroundColor: Colors.blue,
        shape: CustomShapeBorder(),
        leading: Icon(Icons.menu),
        actions: <Widget>[
          IconButton(icon: Icon(Icons.notifications),onPressed: (){},)
        ],
      ),
      */
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

    final double innerCircleRadius = 150.0;

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