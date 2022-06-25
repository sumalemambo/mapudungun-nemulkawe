import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:app/providers/search_provider.dart';


class SearchBar extends StatelessWidget {
  const SearchBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: TextField(
        decoration: const InputDecoration(
          hintText: "Buscar...",
          prefixIcon: Icon(Icons.search),
        ),
        onChanged: (input) {
          context.read<SearchProvider>().setQuery(input);
        },
      ),
    );
  }
}