import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// fontSize multiplier
const double fontMultiplier = 20.0;


class Examples extends StatelessWidget {
  final String examples;

  const Examples({Key? key, required this.examples}) : super(key: key);

  List<List<String>> getExamples(String examples) {
    List<List<String>> exampleList = [];
    var start = examples.indexOf('<dt>');
    var end = examples.indexOf('</dt>');

    while (start != -1) {
      var term = examples.substring(start + 4, end);

      start = examples.indexOf('<dd>');
      end = examples.indexOf('</dd>');
      var definition = examples.substring(start + 4, end);

      exampleList.add([term, definition]);

      examples = examples.substring(end + 5);

      start = examples.indexOf('<dt>');
      end = examples.indexOf('</dt>');
    }

    return exampleList;
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    var exampleList = getExamples(examples);

    return Column(
      children: exampleList.map((example) {
        return Column(
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                '• ' + example[0],
                style: GoogleFonts.openSans(
                  textStyle: TextStyle(
                    fontSize: fontMultiplier * height * 0.001,
                  ),
                ),
              ),
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                example[1],
                style: GoogleFonts.openSans(
                  textStyle: TextStyle(
                    color: Colors.grey,
                    fontStyle: FontStyle.italic,
                    fontSize: fontMultiplier * height * 0.001
                  ),
                ),
              ),
            ),
          ],
        );
      }).toList(),
    );

    return Row(
      children: [
        Expanded(
          child: Text(
            examples,
            style: GoogleFonts.openSans(
              textStyle: TextStyle(
                color: const Color(0xFF333333),
                fontSize: fontMultiplier * height * 0.001
              ),
            ),
          ),
        ),
      ],
    );
  }
}