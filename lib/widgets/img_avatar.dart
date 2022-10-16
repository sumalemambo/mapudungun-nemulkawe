import 'dart:async';
import 'dart:math';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ImgAvatar extends StatefulWidget {
  final String imgPath;

  const ImgAvatar({Key? key, required this.imgPath}) : super(key: key);

  @override
  State createState() => _ImgAvatarState();
}

class _ImgAvatarState extends State<ImgAvatar> {
  late Future<AssetImage> img;

  Future<AssetImage> getImageIfExists() async {
    try {
      /*
      var image = Image.asset('assets/images/words/pudu.jpg');
      Completer<ui.Image> completer = new Completer<ui.Image>();
      image.image
          .resolve(new ImageConfiguration())
          .addListener(new ImageStreamListener((ImageInfo image, bool _) {
        completer.complete(image.image);
      }));
      ui.Image info = await completer.future;
      int width = info.width;
      int height = info.height;
      return completer.future;
       */
      await rootBundle.load(widget.imgPath);
      return AssetImage(widget.imgPath);
    }
    catch (_) {
      return const AssetImage('assets/imgs/default.jpg');
    }
  }

  Widget avatarWidget (AssetImage img) {
    final double width = MediaQuery.of(context).size.width;
    double radius = width * 0.22;

    return CircleAvatar(
      radius: radius,
      backgroundColor: Colors.white,
      child: CircleAvatar(
        backgroundImage: img,
        maxRadius: radius - 5,
      ),
    );
  }

  @override
  void initState() {
    img = getImageIfExists();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<AssetImage>(
      future: img,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done
            && snapshot.hasData
            && snapshot.data != null
        ) {

          return Container(
            decoration: const BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
              boxShadow: [BoxShadow(blurRadius: 5, color: Colors.black, spreadRadius: 1)],
            ),
            child: avatarWidget(snapshot.data!),
          );
        }
        else {
          return const Center(child: CircularProgressIndicator());
        }
      }
    );
  }
}