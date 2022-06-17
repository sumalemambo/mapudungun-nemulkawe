import 'package:flutter/material.dart';
import 'package:app/models/word_model.dart';
import 'package:app/screens/details_screen/components/main.dart';
import 'package:app/widgets/favorite_button.dart';

class SearchWordDelegate extends SearchDelegate<List<Word>>{
  final List<Word> wordList;
  List<Word> _filter = [];

  SearchWordDelegate(this.wordList) : super(searchFieldLabel: 'Buscar...');

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
    // Reiniciar filtro
    _filter = [];

    // Palabras que empiezan con la búsqueda
    _filter.addAll(
        wordList.where((word){
          var wordLower = word.word.toLowerCase();
          //print(wordLower);
          var queryLower = query.toLowerCase();
          return wordLower.startsWith(queryLower);
        }).toList()
    );

    // Palabras que contienen la búsqueda, pero que no empiezan con esta
    _filter.addAll(
        wordList.where((word) {
          var wordLower = word.word.toLowerCase();
          var queryLower = query.toLowerCase();
          var cond1 = wordLower.contains(queryLower);
          var cond2 = !wordLower.startsWith(queryLower);
          return cond1 && cond2;
        }).toList()
    );

    // Palabras cuya traducción contiene la búsqueda
    _filter.addAll(
        wordList.where((word) {
          var wordLower = word.word.toLowerCase();
          var translationLower = word.translation.toLowerCase();
          var queryLower = query.toLowerCase();
          var cond1 = translationLower.contains(queryLower);
          var cond2 = !wordLower.contains(queryLower);
          var cond3 = !wordLower.startsWith(queryLower);
          return cond1 && cond2 && cond3;
        }).toList()
    );

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
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => DetailScreen(word: wordList[i])
                ),
              );
            },
          ),
        );
      },
    );
  }

}