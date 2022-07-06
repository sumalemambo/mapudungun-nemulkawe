import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:app/providers/search_provider.dart';


class CategoryFilter extends StatefulWidget {
  const CategoryFilter({Key? key}) : super(key: key);

  @override
  State createState() => _CategoryFilterState();
}

class _CategoryFilterState extends State<CategoryFilter> {
  String _category = "";

  @override
  Widget build(BuildContext context) {
    var categories = context.watch<SearchProvider>().categories;
    print(categories);
    return Row(
      children: [
        const Text(
            "Categoría:",
            style: TextStyle(
              color: Colors.white,
            )
        ),
        const Expanded(child: SizedBox()),
        SizedBox(
          width: 160,
          child: Card(
            child: Padding(
              padding: const EdgeInsets.all(6.0),
              child: DropdownButton(
                value: _category,
                isDense: true,
                isExpanded: true,
                onChanged: (String? newCategory) {
                  setState(() {
                    _category = newCategory!;
                  });
                  context.read<SearchProvider>().setCategory(newCategory!);
                },
                items: [
                  const DropdownMenuItem(
                    child: Text('Cualquiera'),
                    value: '',
                  ),
                  ...categories.map((category) {
                    return DropdownMenuItem(
                      child: Text(category),
                      value: category,
                    );
                  }),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}