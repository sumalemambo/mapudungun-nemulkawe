import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:app/models/wordModel.dart';
import 'package:google_fonts/google_fonts.dart';

const double fontMultiplier = 20.0;

class TitleRow extends StatefulWidget {
  final String audioPath;
  final WordModel word;

  const TitleRow({
    Key? key,
    required this.audioPath,
    required this.word
  }) : super(key: key);

  @override
  State createState() => _TitleRowState();
}

class _TitleRowState extends State<TitleRow> {
  late Future<bool> audioAvailable;
  final player = AudioPlayer();

  Future<bool> setAudioSrcIfExists() async {
    try {
      await rootBundle.load('assets/' + widget.audioPath);
      await player.setSource(AssetSource(widget.audioPath));
      return true;
    }
    catch (_) {
      return false;
    }
  }

  Widget audioPlayerWidget() {
    return FutureBuilder<bool>(
        future: audioAvailable,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done
              && snapshot.hasData
              && snapshot.data != null
          ) {
            if (snapshot.data!) {
              return TextButton(
                onPressed: () async {
                  await rootBundle.load('assets/' + widget.audioPath); //load audio from assets
                  await player.setSource(AssetSource(widget.audioPath));
                  await player.resume();
                },
                child: const Icon(Icons.volume_up),
              );
            } else {
              return Container();
            }
          }
          else {
            return const Center(child: CircularProgressIndicator());
          }
        }
    );
  }

  @override
  void initState() {
    audioAvailable = setAudioSrcIfExists();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Flexible(
          child: Text(
            widget.word.mapudungun,
            textAlign: TextAlign.center,
            style: GoogleFonts.openSans(
              textStyle: TextStyle(
                  color: const Color(0xFF333333),
                  fontSize: 26,
                  fontWeight: FontWeight.bold
              ),
            ),
          ),
        ),
        audioPlayerWidget()
      ],
    );
  }
}