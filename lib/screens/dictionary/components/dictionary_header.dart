import 'package:flutter/material.dart';
import 'package:expandable/expandable.dart';

import 'dictionary_title_row.dart';
import 'search_bar.dart';
import 'initial_letter_filter.dart';
import 'category_filter.dart';

class DictionaryHeader extends StatefulWidget {
  const DictionaryHeader({Key? key}) : super(key: key);

  @override
  State createState() => _DictionaryHeaderState();
}

class _DictionaryHeaderState extends State<DictionaryHeader> {
  @override
  Widget build(BuildContext context) {
    return ExpandableNotifier(
      child: Container(
        decoration: BoxDecoration(
          color: Colors.green,
          borderRadius: BorderRadius.circular(8),
          boxShadow: const [
            BoxShadow(
              color: Colors.grey,
              blurRadius: 6.0,
              offset: Offset(3.0, 3.0),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            children: <Widget>[
              const DictionaryTitleRow(),
              Expandable(
                collapsed: Container(),
                expanded: Column(
                  children: const <Widget>[
                    SearchBar(),
                    InitialLetterFilter(),
                    CategoryFilter(),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}