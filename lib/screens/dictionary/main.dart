import 'package:flutter/material.dart';
import 'package:app/database/database_helper.dart';
import 'package:app/models/wordModel.dart';
import 'components/dictionary_header.dart';
import 'components/dictionary_list.dart';


class DictionaryScreen extends StatefulWidget {
  const DictionaryScreen({Key? key}) : super(key: key);

  @override
  _DictionaryScreenState createState() => _DictionaryScreenState();
}

class _DictionaryScreenState extends State<DictionaryScreen> with AutomaticKeepAliveClientMixin {
  /* TODO
  Actualmente no se está usando _wordData y el FutureBuilder se debería sacar.
  Pero no se puede sacar directamente porque causa error (se referencia un null)
  Algo se debe hacer, quizás esperar a obtener wordList en lib/word_of_the_day_card.dart
   */
  late Future<List<WordModel>> _wordData;

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    _wordData = _fetchWords();
  }

  Future<List<WordModel>> _fetchWords() async {
    final rows = await DatabaseHelper.selectAll(WordModel.table);
    return WordModel.fromList(rows);
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return FutureBuilder<List<WordModel>>(
      future: _wordData,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: const [
                DictionaryHeader(),
                SizedBox(height: 8.0),
                DictionaryList(),
              ],
            ),
          );
        }
        else {
          return const Center(child: CircularProgressIndicator());
        }
      }
    );
  }
}