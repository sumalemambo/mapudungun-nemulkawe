import 'package:flutter/material.dart';
import 'package:app/models/wordModel.dart';
import 'package:app/screens/details_screen/main.dart';

import 'word_category_box.dart';
import 'favorite_button.dart';



class WordTile extends StatelessWidget {
  final WordModel word;

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
      child:  SizedBox(
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
                        Flexible(
                          child:
                            Text(
                              word.mapudungun,
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                              style: const TextStyle(
                                color: Colors.black,
                                fontSize: 17.0,
                                fontWeight: FontWeight.normal,
                              ),
                            ),
                          ),
                        const SizedBox(width: 8.0),
                        // Categoría
                        WordCategoryBox(category: word.gramatica),
                      ],
                    ),
                    // Significado
                    Text(
                        word.castellano,
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