import 'package:flutter/material.dart';
import 'dart:math' as math;

import 'package:provider/provider.dart';
import 'package:app/providers/search_provider.dart';

class CustomSliverAppBar extends StatelessWidget {
  const CustomSliverAppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      pinned: true,
      snap: true,
      floating: true,
      expandedHeight: 260.0,
      backgroundColor: Colors.green,
      flexibleSpace: FlexibleSpaceBar(
        background: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: const [
              Text(
                'Diccionario',
                style: TextStyle(
                  fontFamily: 'Avenir',
                  color: Colors.white,
                  fontSize: 24.0,
                  fontWeight: FontWeight.w900,
                ),
              ),
              SizedBox(height: 16.0),
              SimpleSearchBar(),
              SizedBox(height: 16.0),
              AdvancedSearchBar(),
            ],
          ),
        ),
      ),
    );
  }
}

/*
class CustomSliverAppBar extends StatelessWidget {
  const CustomSliverAppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const SliverAppBar(
      pinned: true,
      snap: true,
      floating: true,
      expandedHeight: 320.0,
      backgroundColor: Colors.green,
      flexibleSpace: CustomFlexibleSpaceBar(),
    );
  }
}
*/

class CustomFlexibleSpaceBar extends StatelessWidget {
  const CustomFlexibleSpaceBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, c) {
        final settings = context
            .dependOnInheritedWidgetOfExactType<FlexibleSpaceBarSettings>()!;
        final deltaExtent = settings.maxExtent - settings.minExtent;
        final t =
        (1.0 - (settings.currentExtent - settings.minExtent) / deltaExtent)
            .clamp(0.0, 1.0);
        final fadeStart = math.max(0.0, 1.0 - kToolbarHeight / deltaExtent);
        const fadeEnd = 1.0;
        final opacity = 1.0 - Interval(fadeStart, fadeEnd).transform(t);

        return Column(
          children: [
            // Título "Diccionario", se oculta
            Flexible(
              child: Opacity(
                opacity: opacity,
                child: const SizedBox(
                  width: double.infinity,
                  child: Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Text(
                      'Diccionario',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                )
              ),
            ),
            // Barra de búsqueda simple, se mantiene siempre visible
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: SimpleSearchBar(),
            ),
            // Barra de búsqueda avanzada, se oculta
            Flexible(
              child: Opacity(
                opacity: opacity,
                child: const Padding(
                  padding: EdgeInsets.all(16.0),
                  child: AdvancedSearchBar(),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}

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