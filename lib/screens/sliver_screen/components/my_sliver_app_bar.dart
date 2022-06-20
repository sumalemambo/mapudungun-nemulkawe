import 'package:flutter/material.dart';
import 'dart:math' as math;

import 'package:provider/provider.dart';
import 'package:app/providers/search_provider.dart';


class CustomSliverAppBar extends StatelessWidget {
  const CustomSliverAppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const SliverAppBar(
      pinned: true,
      snap: true,
      floating: true,
      expandedHeight: 200.0,
      backgroundColor: Colors.green,
      flexibleSpace: CustomFlexibleSpaceBar(),
    );
  }
}

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
  //final textEditingController = TextEditingController();

  const SimpleSearchBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Card(
      child: TextField(
        decoration: InputDecoration(
          //controller: textEditingController,
          hintText: "Buscar...",
          prefixIcon: Icon(Icons.search),
        ),
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
                items: letters.map((letter) {
                  return DropdownMenuItem(
                    child: Text(letter),
                    value: letter.toLowerCase(),
                  );
                }).toList(),
                onChanged: (String? newInitialLetter) {
                  context.read<SearchProvider>().setInitialLetter(newInitialLetter);
                },
              ),
            ),
          ],
        ),
      ]
    );
  }
}