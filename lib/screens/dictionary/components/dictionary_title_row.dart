import 'package:flutter/material.dart';

import 'package:expandable/expandable.dart';


class DictionaryTitleRow extends StatelessWidget {
  const DictionaryTitleRow({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        // Título
        const Text(
          'Diccionario',
          style: TextStyle(
            fontFamily: 'Avenir',
            fontSize: 24,
            color: Colors.white,
            fontWeight: FontWeight.w900,
          ),
        ),
        const Expanded(child: SizedBox()),
        // Botón que expande o contrae el header con un ExpandableController
        Builder(
          builder: (context) {
            var controller = ExpandableController.of(context, required: true)!;
            return ElevatedButton(
              onPressed: () {controller.toggle();},
              child: Row(
                children: const [
                  Icon(Icons.search),
                  Text("Buscar..."),
                ],
              ),
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Colors.white),
                foregroundColor: MaterialStateProperty.all(Colors.blue),
              ),
            );
          },
        ),
      ],
    );
  }
}