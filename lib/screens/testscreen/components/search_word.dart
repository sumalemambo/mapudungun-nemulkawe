import 'package:app/models/word_model.dart';
import 'package:flutter/material.dart';
import 'package:app/database/database_helper.dart';
import 'main.dart';
import 'package:app/providers/favorites_provider.dart';
import 'package:provider/provider.dart';

class SearchWordDelegate extends SearchDelegate<List<Word>>{
  final List<Word> words;
  List<Word> _filter = [];
  SearchWordDelegate(this.words);


  List<Widget>? buildActions(BuildContext context){
    return[ IconButton(onPressed: (){query='';}, icon: const Icon(Icons.close),)];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back_ios),
      onPressed: ()=> this.close(context,[]),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return _showData(_filter);
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    //_filter = words.where((word){
    //  return word[2].toString().toLowerCase().contains(query.trim().toLowerCase());
    //}).toList();
    _filter = words.where((word){
      var wordLower = word.word.toString().toLowerCase();
      //print(wordLower);
      var queryLower = query.toLowerCase();
      return  wordLower.startsWith(queryLower);
    }).toList();
    return _showData(_filter);
  }

  Widget _showData(List<Word> _filter){
    return ListView.builder(
      itemCount: _filter.length,
      itemBuilder: (context, i) {
        return Card(
          child: ListTile(
            leading: Text(_filter[i].theme),
            title: Text(_filter[i].word),
            subtitle: Text(_filter[i].translation),
            trailing: _FavoriteButton(word: _filter[i]),
          ),
        );
      },
    );
  }

}

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
        print(favorites.item);
        print(favorites.itemIds);
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