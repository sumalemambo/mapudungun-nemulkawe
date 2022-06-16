import 'package:flutter/material.dart';
import 'top_section.dart';
import 'main.dart';


class Dictionary extends StatelessWidget {
  const Dictionary({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: const [
        TopSection(),
        Main(),
      ],
    );
  }
}
