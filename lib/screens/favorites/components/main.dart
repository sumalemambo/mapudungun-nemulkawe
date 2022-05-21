import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:app/providers/favorites_provider.dart';

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
        ? const Center(child: CircularProgressIndicator(),)
        : Consumer<FavoritesProvider>(
          child: const Center(
            child: Text(
              'No se han añadido favoritos',
              textAlign: TextAlign.center,
            ),
          ),
          builder: (context, favoritesProvider, child) => favoritesProvider.
                  item.isEmpty
          ? child!
          : ListView.builder(
              itemCount: favoritesProvider.item.length,
              itemBuilder: (context, i) {
                return Card(
                  child: ListTile(
                    leading: Text(favoritesProvider.item[i].theme),
                    title: Text(favoritesProvider.item[i].word),
                    subtitle: Text(favoritesProvider.item[i].translation),
                    trailing: const Icon(Icons.favorite),
                  ),
                );
              }
          )
        )
      ),
    );
  }
}