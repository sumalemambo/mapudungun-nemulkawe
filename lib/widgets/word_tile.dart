import 'package:flutter/material.dart';
import 'package:app/models/word_model.dart';
import 'package:app/screens/details_screen/main.dart';
import 'favorite_button.dart';


class WordTile extends StatelessWidget {
  final Word word;

  const WordTile({Key? key, required this.word}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DetailScreen(word: word)
          ),
        );
      },
      child: SizedBox(
        height: 60,
        child: Padding(
          padding: const EdgeInsets.only(left: 8.0),
          child: Row(
            children: [
              // Toda la información de la palabra
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Palabra y categoría
                    Row(
                      children: [
                        // Palabra
                        Text(
                          word.word,
                          style: const TextStyle(
                            color: Colors.black,
                            fontSize: 17.0,
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                        const SizedBox(width: 8.0),
                        // Categoría
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.orange[300],
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 2.0, horizontal: 6.0),
                            child: Text(
                              word.theme,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 13.0,
                                fontWeight: FontWeight.normal,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    // Significado
                    Text(
                        word.translation,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          color: Colors.grey,
                          fontSize: 14.0,
                          fontWeight: FontWeight.normal,
                        )
                    ),
                  ],
                ),
              ),

              // Botón de favoritos
              FavoriteButton(word: word),
            ],
          ),
        ),
      ),
    );
  }
}