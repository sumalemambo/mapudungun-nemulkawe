import 'package:flutter/material.dart';
import 'package:app/models/wordModel.dart';
import 'package:app/screens/details_screen/components/img_avatar.dart';
import 'package:app/widgets/favorite_button.dart';
import 'components/details_card.dart';
import 'components/title_row.dart';

// fontSize multiplier
const double fontMultiplier = 20.0;


class DetailScreen extends StatelessWidget {
  final WordModel word;

  const DetailScreen({Key? key, required this.word}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        iconTheme: const IconThemeData(
          color: Colors.black, //change your color here
        ),
      ),
      body: Column(
        children: [
           Flexible(
             child: ListView(
               children: [
                 SizedBox(height: height * 0.055),
                 ImgAvatar(imgPath: 'assets/images/words/${word.id}.jpg'),
                 //ImgAvatar(imgPath: 'assets/images/${word.id}.png'),
                 SizedBox(height: height * 0.035),
                 TitleRow(word: word,audioPath: 'sounds/${word.id}.mp3',),
                 FavoriteButton(word: word),
                 DetailsCard(word: word, height: height,)
               ],
             ),
           )
        ]
      )
    );
  }
}

/*
class TitleRow extends StatelessWidget {
  final WordModel word;

  const TitleRow({Key? key, required this.word}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    final player = AudioPlayer();
    final height = MediaQuery.of(context).size.height;


    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Icon(Icons.volume_up, color: Colors.transparent),
        Flexible(
          child: Text(
              word.mapudungun,
              style: GoogleFonts.openSans(
                textStyle: TextStyle(
                  color: const Color(0xFF333333),
                  fontSize: fontMultiplier * height * 0.0023,
                  fontWeight: FontWeight.bold
                ),
              ),
            ),
        ),
        TextButton(
            onPressed: () async {
              String audioasset = "assets/sounds/test.mp3";
              ByteData bytes = await rootBundle.load(audioasset); //load audio from assets
              await player.setSource(AssetSource('sounds/test.mp'));
              await player.resume();
            },
            child: const Icon(Icons.volume_up),
          ),

      ],
    );
  }
}
 */