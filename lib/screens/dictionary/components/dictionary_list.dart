import 'package:flutter/material.dart';
import 'package:app/widgets/word_tile.dart';

import 'package:provider/provider.dart';
import 'package:app/providers/search_provider.dart';


class DictionaryList extends StatelessWidget {
  const DictionaryList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var _filter = context.watch<SearchProvider>().filter;
    return Expanded(
      child: Card(
        elevation: 4.0,
        child: ListView.builder(
          itemCount: _filter.length,
          itemBuilder: (context, i) {
            return Column(
              children: [
                WordTile(word: _filter[i]),
                const Divider(height: 0.0),
              ]
            );
          },
        ),
      ),
    );
  }
}

