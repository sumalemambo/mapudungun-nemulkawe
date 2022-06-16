import 'package:app/database/database_helper.dart';
import 'package:app/models/word_model.dart';
import 'package:flutter/material.dart';
import 'package:app/widgets/favorite_button.dart';

import '../../details_screen/components/main.dart';

class Main extends StatefulWidget {
  const Main({Key? key}) : super(key: key);

  @override
  _MainState createState() => _MainState();
}

class _MainState extends State<Main> {
  late Future<List<Word>> _wordData;

  @override
  void initState() {
    _wordData = _fetchWords();
    super.initState();
  }

  Future<List<Word>> _fetchWords() async {
    final rows = await DatabaseHelper.selectAll(Word.table);
    return Word.fromList(rows);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Word>>(
      future: _wordData,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          var wordList = snapshot.data!;
          return SizedBox(
              height: 500.0,
              child: Card(
                  margin: const EdgeInsets.fromLTRB(16, 16, 16, 0),
                  elevation: 4.0,
                  child: ListView.builder(
                    // La PageStorageKey almacena la ScrollPosition de la lista
                    key: const PageStorageKey<String>('Diccionario'),
                    itemCount: wordList.length,
                    itemBuilder: (context, i) {
                      return Card(
                        child: ListTile(
                          leading: Text(wordList[i].theme),
                          title: Text(wordList[i].word),
                          subtitle: Text(wordList[i].translation),
                          trailing: FavoriteButton(word: wordList[i]),
                          onTap: () {
                            MaterialPageRoute(
                                builder: (context) => DetailScreen(word: wordList[i])
                            );
                          },
                        ),
                      );
                    },
                  )
              )
          );
        } else {
          return const Center(child: CircularProgressIndicator(),);
        }
      }
    );
  }
}