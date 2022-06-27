import 'package:flutter/material.dart';
import 'package:app/models/word_model.dart';
import 'package:provider/provider.dart';
import 'package:app/providers/favorites_provider.dart';

class FavoriteButton extends StatelessWidget {
  final Word word;

  const FavoriteButton({required this.word, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var isInFavorites = context.select<FavoritesProvider, bool>(
            (favorites) => favorites.itemIds.contains(word.id)
    );

    return IconButton(
      padding: const EdgeInsets.all(4.0),
      onPressed: isInFavorites
          ?  () {
        var favorites = context.read<FavoritesProvider>();
        favorites.remove(word.id!);
      }
          : () {
        // If the item is not in cart, we let the user add it.
        // We are using context.read() here because the callback
        // is executed whenever the user taps the button. In other
        // words, it is executed outside the build method.
        var favorites = context.read<FavoritesProvider>();
        favorites.add(word.id!);
      },
      icon: isInFavorites
          ? const Icon(
          Icons.favorite,
          color: Colors.pink,
          semanticLabel: 'ADDED'
      )
          : const Icon(Icons.favorite, color: Colors.grey,),
    );
  }
}