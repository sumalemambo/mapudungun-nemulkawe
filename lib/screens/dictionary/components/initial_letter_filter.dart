import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:app/providers/search_provider.dart';


class InitialLetterFilter extends StatefulWidget {
  const InitialLetterFilter({Key? key}) : super(key: key);

  @override
  State createState() => _InitialLetterFilterState();
}

class _InitialLetterFilterState extends State<InitialLetterFilter> {
  final List<String> letters = const [
    'A', 'Ch', 'D', 'E', 'F', 'G', 'I', 'K', 'L', 'L\'',
    'Ll', 'M', 'N', 'N\'', 'Ñ', 'Ng', 'O', 'P', 'R', 'S',
    'Sh', 'T', 'T\'', 'Tr', 'U', 'Ü', 'W', 'Y',
  ];

  String _initialLetter = '';

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Text(
            "Comienza con:",
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
                value: _initialLetter,
                isDense: true,
                isExpanded: true,
                onChanged: (String? newInitialLetter) {
                  setState(() {
                    _initialLetter = newInitialLetter!;
                  });
                  context.read<SearchProvider>().setInitialLetter(newInitialLetter!);
                },
                items: [
                  const DropdownMenuItem(
                    child: Text('Cualquier letra'),
                    value: '',
                  ),
                  ...letters.map((letter) {
                    return DropdownMenuItem(
                      child: Text(letter),
                      value: letter.toLowerCase(),
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