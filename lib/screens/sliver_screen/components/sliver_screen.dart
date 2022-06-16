import 'package:flutter/material.dart';
import 'package:app/database/database_helper.dart';
import 'package:app/models/word_model.dart';
import 'my_sliver_app_bar.dart';
import 'my_sliver_list.dart';


class SliverScreen extends StatefulWidget {
  const SliverScreen({Key? key}) : super(key: key);

  @override
  _SliverScreenState createState() => _SliverScreenState();
}

class _SliverScreenState extends State<SliverScreen> with AutomaticKeepAliveClientMixin {
  late Future<List<Word>> _wordData;

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    _wordData = _fetchWords();
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
          return Card(
            margin: const EdgeInsets.fromLTRB(16, 16, 16, 0),
            elevation: 4.0,
            child: CustomScrollView(
              slivers: [
                MySliverAppBar(wordList: wordList),
                MySliverList(wordList: wordList),
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