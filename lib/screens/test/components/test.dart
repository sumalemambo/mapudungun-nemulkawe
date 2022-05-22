import 'package:flutter/material.dart';
import 'package:app/screens/test/components/main.dart';

class Test extends StatelessWidget {
  const Test({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView(
        children: const [
          Main(),
        ],
      ),
    );
  }
}