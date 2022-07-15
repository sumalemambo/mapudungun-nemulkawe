import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:typed_data';

import 'package:audioplayers/audioplayers.dart';

import 'package:app/models/wordModel.dart';
import 'package:app/screens/details_screen/components/img_avatar.dart';

import 'package:app/widgets/favorite_button.dart';
import 'package:google_fonts/google_fonts.dart';
import 'components/details_card.dart';

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
                 ImgAvatar(imgPath: 'assets/images/${word.id}.png'),
                 SizedBox(height: height * 0.035),
                 TitleRow(word: word),
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

class ImageAvatar extends StatelessWidget {
  final String imageSrc;

  const ImageAvatar({Key? key, required this.imageSrc}) : super(key: key);


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
          // backgroundImage: AssetImage(imageSrc),
          maxRadius: 100,
          child: const Text('?'),
        ),
      ),
    );

  }
}

class TitleRow extends StatelessWidget {
  final WordModel word;

  const TitleRow({Key? key, required this.word}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final player = AudioPlayer();
    final height = MediaQuery.of(context).size.height;

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          child:
            Text(
              word.mapudungun,
              textAlign: TextAlign.center,
              style: GoogleFonts.playfairDisplay(
                textStyle: TextStyle(
                    color: const Color(0xFF333333),
                    fontSize: fontMultiplier * height * 0.00205,
                ),
              ),
            ),
        ),
        TextButton(
          onPressed: () async {
            String audioasset = "assets/sounds/test.mp3";
            ByteData bytes = await rootBundle.load(audioasset); //load audio from assets
            Uint8List audiobytes = bytes.buffer.asUint8List(bytes.offsetInBytes, bytes.lengthInBytes);
            await player.playBytes(audiobytes);
          },
          child: const Icon(Icons.volume_up),
        ),
      ],
    );
  }
}