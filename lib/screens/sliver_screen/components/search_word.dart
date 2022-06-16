import 'package:app/models/word_model.dart';
import 'package:flutter/material.dart';
import 'package:app/widgets/favorite_button.dart';

class SearchWordDelegate extends SearchDelegate<List<Word>>{
  final List<Word> words;
  List<Word> _filter = [];
  SearchWordDelegate(this.words);

  @override
  List<Widget>? buildActions(BuildContext context){
    return [
      IconButton(
        onPressed: () {query = '';},
        icon: const Icon(Icons.close),
      ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back_ios),
      onPressed: () => close(context, []),
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
            trailing: FavoriteButton(word: _filter[i]),
          ),
        );
      },
    );
  }

}