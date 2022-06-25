import 'package:flutter/material.dart';
import 'package:app/screens/details_screen/main.dart';
import 'package:app/widgets/favorite_button.dart';

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
                        builder: (context) => DetailScreen(word: _filter[i])
                    ),
                  );
                },
              ),
            );
          },
        ),
      ),
    );
  }
}