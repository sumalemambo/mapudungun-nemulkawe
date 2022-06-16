import 'package:flutter/material.dart';
import 'package:app/models/word_model.dart';
import 'search_word.dart';

class MySliverAppBar extends StatelessWidget {
  final List<Word> wordList;

  const MySliverAppBar({Key? key, required this.wordList}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      pinned: true,
      floating: true,
      expandedHeight: 160.0,
      flexibleSpace: FlexibleSpaceBar(
        title: Center(
          child: ElevatedButton(
            child: const Text(
              "Buscar",
              style: TextStyle(color: Colors.white),
            ),
            onPressed: () {
              showSearch(
                context: context,
                delegate: SearchWordDelegate(wordList),
              );
            },
          ),
        ),
      ),
    );
  }
}