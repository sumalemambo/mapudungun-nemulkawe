import 'package:flutter/material.dart';

List images = [
  'lib/assets/image-1.png',
  'lib/assets/image-2.jpg',
  'lib/assets/image-3.png',
];

class AboutDetails extends StatelessWidget {
  const AboutDetails({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        bottom: false,
        child: Stack(
          children: <Widget>[
            SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(32.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Center(child: Image.asset('lib/assets/logo.jpg',height: 200)),
                        Container(height: 20),
                        const Text(
                          'FIWFIW ÑI DUNGUN',
                          style: TextStyle(
                            fontFamily: 'Avenir',
                            fontSize: 35,
                            color: Color(0xFF414C6B),
                            fontWeight: FontWeight.w900,
                          ),
                          textAlign: TextAlign.left,
                        ),
                        const Text(
                          'Organización',
                          style: TextStyle(
                            fontFamily: 'Avenir',
                            fontSize: 20,
                            color: Color(0xFF414C6B),
                            fontWeight: FontWeight.w300,
                          ),
                          textAlign: TextAlign.left,
                        ),
                        const Divider(color: Colors.black38),
                        const SizedBox(height: 16),
                        const Text(
                          'Fiw-Fiw ñi Dungun es una asociación sin fines de lucro que trabaja por la revitalización del mapuzugun, a través de su promoción y enseñanza en jóvenes y adultos. Desde su creación, realiza cursos e internados de mapuzugun en las regiones del Biobío, además de cooperar en la enseñanza de la lengua en otros internados levantados por otras organizaciones mapuche.',
                          style: TextStyle(
                            fontFamily: 'Avenir',
                            fontSize: 20,
                            color: Color(0xff868686),
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        const SizedBox(height: 16),
                        const Divider(color: Colors.black38),
                      ],
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(left: 32.0),
                    child: Text(
                      'Galería',
                      style: TextStyle(
                        fontFamily: 'Avenir',
                        fontSize: 25,
                        color: Color(0xff47455f),
                        fontWeight: FontWeight.w300,
                      ),
                      textAlign: TextAlign.left,
                    ),
                  ),
                  Container(
                    height: 280,
                    padding: const EdgeInsets.only(left: 32.0, right: 32.0, top: 16.0, bottom: 32.0),
                    child: ListView.builder(
                        itemCount: images.length,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, int index) {
                          return Card(
                            clipBehavior: Clip.antiAlias,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(24),
                            ),
                            child: AspectRatio(
                                aspectRatio: 1,
                                child: Image.asset(
                                  images[index],
                                  fit: BoxFit.cover,
                                )),
                          );
                        }),
                  ),
                ],
              ),
            ),
            IconButton(
              icon: const Icon(Icons.arrow_back_ios),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }
}