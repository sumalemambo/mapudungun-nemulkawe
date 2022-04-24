import 'package:flutter/material.dart';
import 'top_section.dart';
import 'main.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView(
        children: [
          TopSection(),
          Main(),
        ],
      )
    );
  }
}