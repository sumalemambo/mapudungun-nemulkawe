import 'package:flutter/material.dart';
import 'details.dart';

const double fontMultiplier = 20.0;

class AboutCard extends StatelessWidget {
  const AboutCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    final double height = MediaQuery.of(context).size.height;
    return SizedBox(
      child: Column(
        children: <Widget>[
          Container(
              width: width * 0.09,
              height: height * 0.061,
              child: ElevatedButton(
                child: Center(
                    child: Icon(Icons.question_mark_rounded ,size: width * fontMultiplier * 0.0025)),
                  onPressed: () {Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const AboutDetails(),
            ),
          );},
                style: ButtonStyle(
                  elevation: MaterialStateProperty.all(15),
                    shadowColor: MaterialStateProperty.all(Colors.blue),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(360),
                        )
                    )
                ),
              )),
        ],
      ),
    );
  }
}