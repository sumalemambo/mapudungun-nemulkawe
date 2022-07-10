import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ImgAvatar extends StatefulWidget {
  final String imgPath;

  const ImgAvatar({Key? key, required this.imgPath}) : super(key: key);

  @override
  State createState() => _ImgAvatarState();
}

class _ImgAvatarState extends State<ImgAvatar> {
  late Future<AssetImage?> img;

  Future<AssetImage?> getImageIfExists() async {
    try {
      await rootBundle.load(widget.imgPath);
      return AssetImage(widget.imgPath);
    } catch(_) {
      return null;
    }
  }

  @override
  void initState() {
    img = getImageIfExists();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<AssetImage?>(
      future: img,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return Container();
        }
        else {
          return const Center(child: CircularProgressIndicator());
        }
      }
    );
  }
}