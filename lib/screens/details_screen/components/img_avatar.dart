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

  Widget avatar () {
    return CircleAvatar(

    );
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
        if (snapshot.connectionState == ConnectionState.done &&
            snapshot.hasData) {
          final double width = MediaQuery.of(context).size.width;

          if (snapshot.data != null) {

          }
          return Container(
            decoration: const BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
              boxShadow: [BoxShadow(blurRadius: 5, color: Colors.black, spreadRadius: 1)],
            ),
          );
        }
        else {
          return const Center(child: CircularProgressIndicator());
        }
      }
    );
  }
}