import 'package:flutter/material.dart';
import 'main.dart';
import 'search_bar.dart';

class TestScreen extends StatelessWidget {
  const TestScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        child: ListView(
          children: [
            SearchBar(),
            Main(),
          ],
        )
    );
  }
}