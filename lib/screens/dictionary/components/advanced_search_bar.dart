import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:app/providers/search_provider.dart';


class AdvancedSearchBar extends StatefulWidget {
  const AdvancedSearchBar({Key? key}) : super(key: key);

  @override
  _AdvancedSearchBarState createState() => _AdvancedSearchBarState();
}

class _AdvancedSearchBarState extends State<AdvancedSearchBar> {
  final List<String> letters = const [
    'A', 'Z', 'Ü', 'M', 'Ch', 'E', 'F', 'I', 'K', 'T',
    'Nh', 'Tx', 'O', 'Y', 'Q', 'G', 'Lh', 'Ñ', 'R', 'S',
    'Ll', 'P', 'U', 'W', 'L', 'N',
  ];

  String? _initialLetter;
  String? _category;

  @override
  Widget build(BuildContext context) {
    var categories = context.watch<SearchProvider>().categories;
    return Column(
        children: [
          // Filtro por grafema inicial
          Row(
            children: [
              const Text(
                  "Comienza con:",
                  style: TextStyle(
                    color: Colors.white,
                  )
              ),
              const Expanded(child: SizedBox()),
              Card(
                child: DropdownButton(
                  value: _initialLetter,
                  items: letters.map((letter) {
                    return DropdownMenuItem(
                      child: Text(letter),
                      value: letter.toLowerCase(),
                    );
                  }).toList(),
                  onChanged: (String? newInitialLetter) {
                    setState(() {
                      _initialLetter = newInitialLetter;
                    });
                    context.read<SearchProvider>().setInitialLetter(newInitialLetter);
                  },
                ),
              ),
            ],
          ),

          // Filtro por categoría
          Row(
            children: [
              const Text(
                  "Categoría:",
                  style: TextStyle(
                    color: Colors.white,
                  )
              ),
              const Expanded(child: SizedBox()),
              Card(
                child: DropdownButton(
                  value: _category,
                  items: categories.map((category) {
                    return DropdownMenuItem(
                      child: Text(category),
                      value: category,
                    );
                  }).toList(),
                  onChanged: (String? newCategory) {
                    setState(() {
                      _category = newCategory;
                    });
                    context.read<SearchProvider>().setCategory(newCategory);
                  },
                ),
              ),
            ],
          ),
        ]
    );
  }
}