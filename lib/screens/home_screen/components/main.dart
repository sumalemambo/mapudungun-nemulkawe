import 'package:app/models/word_model.dart';
import 'package:flutter/material.dart';
import 'dart:math';
import 'package:app/global_var.dart';
import 'package:app/models/database_helper.dart';


class Main extends StatefulWidget {
  @override
  _MainState createState() => _MainState();
}

class _MainState extends State<Main> {
  late Word word;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();

    insertTest();
  }

  void insertTest() async {
    setState(() => isLoading = true);
    word = await DatabaseHelper.instance.readWord(1);
    setState(() => isLoading = false);
  }


  final int randint = Random(
      DateTime.now().millisecondsSinceEpoch ~/ 86400000
  ).nextInt(data['mapuzuguletuain']!.length - 1) + 1;

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 500.0,
        child: Card(
          margin: EdgeInsets.fromLTRB(16, 16, 16, 0),
          elevation: 4.0,
          child: Padding(
            padding: EdgeInsets.all(12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      data['mapuzuguletuain']![randint][2][0].toUpperCase()
                          + data['mapuzuguletuain']![randint][2].substring(1),
                      style: const TextStyle(
                          fontSize: 45,
                          fontFamily: 'Roboto',
                          color: Colors.black
                      ),
                    )
                  ]
                ),
                Text(
                    data['mapuzuguletuain']![randint][0],
                    style: const TextStyle(
                      fontSize: 18,
                      fontFamily: 'Roboto',
                      color: Colors.grey,
                      fontStyle: FontStyle.italic,
                    ),
                ),
                const SizedBox(
                  height: 10.0,
                ),
                Row(
                  children: [
                    const Text(
                      "Definicion: ",
                      style: TextStyle(
                        fontWeight: FontWeight.bold
                      ),
                    ),
                    Text(
                      data['mapuzuguletuain']![randint][3],
                    )
                  ],
                ),
                Row(
                  children: isLoading
                  ? [const Center(child: CircularProgressIndicator(),)]
                  : [
                    Text(
                      word.theme,
                    ),
                    Text(
                      word.translation,
                    )
                  ],
                )
              ],
            ),
          ),
        )
    );
  }
}