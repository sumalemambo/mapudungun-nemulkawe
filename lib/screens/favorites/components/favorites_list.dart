import 'package:flutter/material.dart';

import 'package:app/widgets/favorite_button.dart';
import '../../../models/word_model.dart';


class FavoritesList extends StatefulWidget {
  final List<Word> favoritesList;
  const FavoritesList({Key? key, required this.favoritesList}) : super(key: key);

  @override
  State createState() => _FavoritesListState();
}

class _FavoritesListState extends State<FavoritesList> with AutomaticKeepAliveClientMixin{
  @override
  bool get wantKeepAlive => false;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final favoritesList = widget.favoritesList;

    return Expanded(
      child: Card(
        elevation: 4.0,
        child: ListView.builder(
          // La PageStorageKey almacena la Scroll Position de la lista
          key: const PageStorageKey<String>('Favoritos'),
          itemCount: favoritesList.length,
          itemBuilder: (context, i) {
            return Card(
              child: ListTile(
                leading: Text(favoritesList[i].theme),
                title: Text(favoritesList[i].word),
                subtitle: Text(favoritesList[i].translation),
                trailing: FavoriteButton(word: favoritesList[i]),
              ),
            );
          },
        ),
      ),
    );
  }
}

