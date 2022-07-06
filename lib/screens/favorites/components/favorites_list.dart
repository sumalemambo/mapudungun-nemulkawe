import 'package:flutter/material.dart';
import 'package:app/models/word_model.dart';

import 'package:app/widgets/word_tile.dart';


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
          itemCount: favoritesList.length,
          itemBuilder: (context, i) {
            return Column(
              children: [
                //WordTile(word: favoritesList[i]),
                const Divider(height: 0.0),
              ]
            );
          },
        ),
      ),
    );
  }
}

