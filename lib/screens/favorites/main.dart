import 'package:flutter/material.dart';
import 'package:app/models/database_helper.dart';
import 'package:provider/provider.dart';
import 'package:app/models/favorites.dart';

class Main extends StatefulWidget {
  const Main({Key? key}) : super(key: key);

  @override
  _MainState createState() => _MainState();
}

class _MainState extends State<Main> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: FutureBuilder(
          future: Provider.of<FavoritesProvider>(context, listen: false)
              .selectFavorites(),
          builder: (context, snapshot) => snapshot.connectionState ==
              ConnectionState.waiting
              ? const Center(child: CircularProgressIndicator())
              : const Center(child: CircularProgressIndicator())
      ),
    );
  }

}