import 'package:flutter/material.dart';
import 'package:app/database/database_helper.dart';
import 'package:app/models/word_model.dart';
import 'main.dart';
import 'search_bar.dart';
import 'verb_conjugator.dart';

class SliverScreen extends StatelessWidget {
  const SliverScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: DatabaseHelper.selectAll(Word.table),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          var wordList = snapshot.data!;
          return CustomScrollView(
            slivers: const [
              SliverAppBar(),
            ],
          );
        }
        else {
          return const Center(child: CircularProgressIndicator());
        }
      }
    );
  }
}