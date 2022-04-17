import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

var now = DateTime.now();
var formatter = DateFormat.yMMMd('en_US');
String today = formatter.format(now);

class TopSection extends StatelessWidget {
  const TopSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20.0, 10.0, 0.0, 0.0),
      child: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              today,
              style: const TextStyle(color: Colors.grey, fontSize: 13.0),
            ),
            const Text(
                'Today',
                  style: TextStyle(fontSize: 33.0),
            ),
          ],
        ),
      )
    );
  }
}