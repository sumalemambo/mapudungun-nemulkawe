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
    // Screen width
    final double width = MediaQuery.of(context).size.width;
    // Screen height
    final double height = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        iconTheme: const IconThemeData(
          color: Colors.black, //change your color here
        ),
      ),
      body: ListView(
        children: [
          SizedBox(height: height * 0.055),
          const _ImageAvatar(imageSrc: 'assets/azum6.png'),
          SizedBox(height: height * 0.035),
          Text(
            word.word,
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 30.0),
          ),
          _WordDetails(
              height: height,
              width: width,
              word: word
          )
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
  final double height;
  final double width;

  const _WordDetails({
    required this.word,
    required this.height,
    required this.width
  });

  @override
  Widget build(BuildContext context) {
    const double fontMultiplier = 20.0;

    return Container(
      constraints: BoxConstraints(
          minHeight: height * 0.45,
          minWidth: double.infinity,
          maxHeight: double.infinity
      ),
       child: Card(
          margin: const EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 16.0),
          color: Colors.white,
          elevation: 4.0,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
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
                SizedBox(
                  height: height * 0.0165,
                ),
                Row(
                  children: [
                    Text(
                      "Definición ",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: fontMultiplier * height * 0.0015,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: height * 0.01,
                ),
                Flexible(
                    child: Text(
                        word.translation,
                        style: TextStyle(fontSize: fontMultiplier * height * 0.001)
                    )
                ),
                SizedBox(
                    height: height * 0.0165,
                ),
                Row(
                  children: [
                    Text(
                      "Ejemplos",
                      style: TextStyle(
                        fontSize: fontMultiplier * height * 0.0015,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: height * 0.01,
                ),
                Flexible(
                    child: Text(
                      word.examples,
                      style: TextStyle(fontSize: fontMultiplier * height * 0.001),
                    )
                ),
                SizedBox(
                  height: height * 0.1,
                ),
                Center(
                  child: FavoriteButton(word: word,),
                ),
              ],
            ),
          ),
       ),
    );
  }
}