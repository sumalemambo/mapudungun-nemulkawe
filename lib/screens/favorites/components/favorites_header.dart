import 'package:flutter/material.dart';
import 'package:expandable/expandable.dart';

//import 'package:provider/provider.dart';
//import 'package:app/providers/search_provider.dart';


class FavoritesHeader extends StatefulWidget {
  const FavoritesHeader({Key? key}) : super(key: key);

  @override
  State createState() => _FavoritesHeaderState();
}

class _FavoritesHeaderState extends State<FavoritesHeader> {
  @override
  Widget build(BuildContext context) {
    return ExpandableNotifier(
      child: Container(
        decoration: BoxDecoration(
          color: Colors.red,
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
              Row(
                children: [
                  const Text(
                    'Favoritos',
                    style: TextStyle(
                      fontFamily: 'Avenir',
                      fontSize: 24,
                      color: Colors.white,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                  const Expanded(child: SizedBox()),
                  /*
                  Builder(
                      builder: (context) {
                        var controller = ExpandableController.of(context, required: true)!;
                        return ElevatedButton(
                            child: Row(
                              children: [
                                Icon(Icons.search),
                                Text("Buscar..."),
                              ],
                            ),
                            onPressed: () {
                              controller.toggle();
                            }
                        );
                      }
                  ),
                  */
                ],
              ),
              /*
              Expandable(
                collapsed: Container(),
                expanded: Column(
                  children: const <Widget>[
                    SimpleSearchBar(),
                    AdvancedSearchBar(),
                  ],
                ),
              )
              */
            ],
          ),
        ),
      ),
    );

  }
}

/*
class SimpleSearchBar extends StatelessWidget {
  const SimpleSearchBar({Key? key}) : super(key: key);

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
        )
    );
  }
}

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
*/