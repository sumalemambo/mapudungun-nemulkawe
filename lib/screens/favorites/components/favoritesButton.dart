import 'package:flutter/material.dart';
import 'package:app/models/word_model.dart';
import 'package:provider/provider.dart';
import 'package:app/providers/favorites_provider.dart';

class _FavoriteButton extends StatelessWidget {
  final Word word;

  const _FavoriteButton({required this.word});

  @override
  Widget build(BuildContext context) {

    var isInFavorites = context.select<FavoritesProvider, bool>(
            (favorites) => favorites.itemIds.contains(word.id)
    );

    return IconButton(
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