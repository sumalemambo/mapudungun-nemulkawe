import 'package:flutter/material.dart';
import 'package:app/models/word_model.dart';
import 'package:app/screens/details_screen/components/main.dart';
import 'package:app/widgets/favorite_button.dart';


class MySliverList extends StatelessWidget {
  final List<Word> wordList;

  const MySliverList({Key? key, required this.wordList}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (context, i) {
          return Card(
            child: ListTile(
              leading: Text(wordList[i].theme),
              title: Text(wordList[i].word),
              subtitle: Text(wordList[i].translation),
              trailing: FavoriteButton(word: wordList[i]),
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
        childCount: wordList.length,
      )
    );
  }
}