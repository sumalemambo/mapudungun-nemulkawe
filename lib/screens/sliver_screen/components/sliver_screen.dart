import 'package:flutter/material.dart';
import 'package:app/database/database_helper.dart';
import 'package:app/models/word_model.dart';
import 'package:app/widgets/favorite_button.dart';
import 'main.dart';
import 'search_bar.dart';


class SliverScreen extends StatelessWidget {
  const SliverScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: DatabaseHelper.selectAll(Word.table),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          final list = snapshot.data! as List<Map<String, dynamic>>;
          final wordList = Word.fromList(list);
          return Card(
            margin: const EdgeInsets.fromLTRB(16, 16, 16, 0),
            elevation: 4.0,
            child: CustomScrollView(
              slivers: [
                const SliverAppBar(
                  pinned: true,
                  floating: true,
                  expandedHeight: 160.0,

                ),
                SliverList(
                  delegate: SliverChildBuilderDelegate(
                      (context, i) {
                        return Card(
                          child: ListTile(
                            leading: Text(wordList[i].theme),
                            title: Text(wordList[i].word),
                            subtitle: Text(wordList[i].translation),
                            trailing: FavoriteButton(word: wordList[i]),
                          ),
                        );
                      }
                  )
                ),
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