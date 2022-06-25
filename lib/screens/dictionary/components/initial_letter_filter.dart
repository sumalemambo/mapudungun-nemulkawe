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
    'A', 'Z', 'Ü', 'M', 'Ch', 'E', 'F', 'I', 'K', 'T',
    'Nh', 'Tx', 'O', 'Y', 'Q', 'G', 'Lh', 'Ñ', 'R', 'S',
    'Ll', 'P', 'U', 'W', 'L', 'N',
  ];

  String? _initialLetter;

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