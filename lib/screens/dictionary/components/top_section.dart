import 'package:flutter/material.dart';
import 'package:intl/intl.dart';


class TopSection extends StatelessWidget {
  const TopSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.fromLTRB(20.0, 10.0, 0.0, 0.0),
        child: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              Text(
                'Diccionario',
                style: TextStyle(fontSize: 33.0),
              ),
            ],
          ),
        )
    );
  }
}