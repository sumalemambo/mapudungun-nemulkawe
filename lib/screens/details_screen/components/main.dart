import 'package:flutter/material.dart';
import 'package:app/models/word_model.dart';
import 'package:app/widgets/favorite_button.dart';

class DetailScreen extends StatefulWidget {
  final Word word;

  const DetailScreen({Key? key, required this.word}) : super(key: key);

  @override
  _MainState createState() => _MainState();
}

class _MainState extends State<DetailScreen> {

  @override
  Widget build(BuildContext context) {
    final Word word = widget.word;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        iconTheme: const IconThemeData(
          color: Colors.black, //change your color here
        ),
      ),
      body: ListView(
        children: [
          const SizedBox(height: 40.0),
          const _ImageAvatar(imageSrc: 'assets/azum6.png'),
          const SizedBox(height: 25.0),
          Text(
            word.word,
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 30.0),
          ),
          _WordDetails(word: word)
        ],
      ),
    );
  }
}

class _ImageAvatar extends StatelessWidget {
  final String imageSrc;

  const _ImageAvatar({required this.imageSrc});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        shape: BoxShape.circle,
        boxShadow: [BoxShadow(blurRadius: 5, color: Colors.black, spreadRadius: 1)],
      ),
      child: CircleAvatar(
        radius: 105,
        backgroundColor: Colors.white,
        child: CircleAvatar(
          backgroundImage: AssetImage(imageSrc),
          maxRadius: 100,
        ),
      ),
    );
  }
}

class _TitleRow extends StatelessWidget {
  final String word;

  const _TitleRow({required this.word});

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

class _WordDetails extends StatelessWidget {
  final Word word;

  const _WordDetails({required this.word});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.fromLTRB(16, 16, 16, 0),
      color: Colors.white,
      elevation: 4.0,
      child: Padding(
        padding: EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              word.theme,
              style: const TextStyle(
                  fontStyle: FontStyle.italic,
                  color: Colors.grey
              ),
            ),
            const SizedBox(
              height: 10.0,
            ),
            Row(
              children: const [
                Text(
                  "Definición ",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20.0
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 7.0,
            ),
            Row(
              children: [
                Text(
                  word.translation,
                ),
              ],
            ),
            const SizedBox(
                height: 12.0,
            ),
            Row(
              children: const [
                Text(
                  "Ejemplos",
                  style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 7.0,
            ),
            Row(
              children: [
                Text(
                    word.examples,
                ),
              ],
            ),
            const SizedBox(
              height: 15.0,
            ),
            Center(
              child: FavoriteButton(word: word,),
            ),
          ],
        ),
      ),
    );
  }
}