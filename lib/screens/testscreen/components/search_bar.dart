import 'package:app/database/database_helper.dart';
import 'package:app/models/word_model.dart';
import 'package:flutter/material.dart';
import 'package:app/screens/testscreen/components/search_word.dart';

class SearchBar extends StatefulWidget {
  const SearchBar({Key? key}) : super(key: key);

  @override
  _SearchBar createState() => _SearchBar();
}

class _SearchBar extends State<SearchBar> {
  late Future<List<Word>> _wordData;

  @override
  void initState() {
    _wordData = _fetchWords();
    super.initState();
  }

  Future<List<Word>> _fetchWords() async {
    final rows = await DatabaseHelper.selectAll(
        Word.table,
    );

    return Word.fromList(rows);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Word>>(
        future: _wordData,
        builder: (
            BuildContext context,
            AsyncSnapshot<List<Word>> snapshot
            ) {
          if (snapshot.hasData) {
            var wordList = snapshot.data!;
            return Padding(
              padding: const EdgeInsets.fromLTRB(19.0, 10.0, 19.0, 0.0),
              child: AppBar(
                automaticallyImplyLeading: false,
                title: ListTile(
                  onTap: (){
                    showSearch(context: context, delegate: SearchWordDelegate(wordList));
                  },
                  title: const Text(
                    "Buscar",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            );
          } else {
            return const Center(child: CircularProgressIndicator(),);
          }
        }
    );
  }
}