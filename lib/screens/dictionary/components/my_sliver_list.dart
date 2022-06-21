import 'package:flutter/material.dart';
import 'package:app/screens/details_screen/components/main.dart';
import 'package:app/widgets/favorite_button.dart';

import 'package:provider/provider.dart';
import 'package:app/providers/search_provider.dart';


class MySliverList extends StatelessWidget {
  const MySliverList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var _filter = context.watch<SearchProvider>().filter;
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (context, i) {
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
        childCount: _filter.length,
      )
    );
  }
}