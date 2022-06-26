import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:app/models/word_model.dart';


final persons = [
  "iñche", "iñchiw", "iñchiñ",
  "eymi", "eymu", "eymün",
  "fey", "feyegu", "feyegün"
];

final endingsVowel = [
  ["n", "yu", "iñ", "ymi", "ymu", "ymün", "y", "ygu", "ygün"],
  ["li", "liyu", "liyiñ", "lmi", "lmu", "lmün", "le", "le egu", "le egün"],
  ["chi", "yu", "iñ", "ge", "mu", "mün", "pe", "pe egu", "pe egün"]
];

final endingsI = [
  ["n", "yu", "yiñ", "mi", "mu", "mün", "", "gu", "gün"],
  ["li", "liyu", "liyiñ", "lmi", "lmu", "lmün", "le", "le egu", "le egün"],
  ["chi", "yu", "yiñ", "ge", "mu", "mün", "pe", "pe egu", "pe egün"]
];

final endingsL = [
  ["ün", "iyu", "iyiñ", "imi", "imu", "imün", "i", "igu", "igün"],
  ["-li", "-liyu", "-liyiñ", "ülmi", "ülmu", "ülmün", "-le", "-le egu", "-le egün"],
  ["chi", "yu", "iñ", "ge", "mu", "mün", "pe", "pe egu", "pe egün"]
];

final endingsConsonant = [
  ["ün", "iyu", "iyiñ", "imi", "imu", "imün", "i", "igu", "igün"],
  ["li", "liyu", "liyiñ", "ülmi", "ülmu", "ülmün", "le", "le egu", "le egün"],
  ["chi", "yu", "iñ", "ge", "mu", "mün", "pe", "pe egu", "pe egün"]
];

// fontSize multiplier
const double fontMultiplier = 20.0;


class ConjugationTab extends StatefulWidget {
  final Word word;

  const ConjugationTab({Key? key, required this.word}) : super(key: key);

  @override
  State createState() => _ConjugationTabState();
}

class _ConjugationTabState extends State<ConjugationTab> {
  int _selectedIndex = 0;
  late List<List<String>> _conjugations;

  @override
  void initState() {
    super.initState();
    _conjugations = conjugate(widget.word.word);
  }

  List<List<String>> conjugate(String s) {
    s = s.substring(0, s.length-1);

    List<String> vowelsWithoutI = ['a', 'ü', 'e', 'o', 'u'];
    List<List<String>> endings;
    if (vowelsWithoutI.any((vowel) => s.endsWith(vowel))) {
      endings = endingsVowel;
    }
    else if (s.endsWith('i')) {
      endings = endingsI;
    }
    else if (s.endsWith('l')) {
      endings = endingsL;
    }
    else {
      endings = endingsConsonant;
    }

    var conjugations = endings.map((endingList) {
      return endingList.map((ending) => s + ending).toList();
    }).toList();

    return conjugations;
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    final tileHeight = height / 15;
    final tileWidth = width / 5.4;
    const duration = Duration(milliseconds: 300);

    MaterialColor _materialColor;
    if (_selectedIndex == 0) {
      _materialColor = Colors.orange;
    }
    else if (_selectedIndex == 1) {
      _materialColor = Colors.cyan;
    }
    else {
      _materialColor = Colors.lightGreen;
    }

    return Column(
      children: [
        Align(
          alignment: Alignment.centerLeft,
          child: Text(
            'Conjugaciones',
            style: GoogleFonts.openSans(
              textStyle: TextStyle(
                  color: const Color(0xFF333333),
                  fontSize: fontMultiplier * height * 0.0015,
                  fontWeight: FontWeight.bold
              ),
            ),
          ),
        ),
        const SizedBox(height: 16.0),

        // Modo gramatical
        Text(
          'Modo gramatical',
          style: GoogleFonts.openSans(
            textStyle: TextStyle(
                color: const Color(0xFF333333),
                fontSize: fontMultiplier * height * 0.0012,
                fontWeight: FontWeight.bold
            ),
          ),
        ),
        const SizedBox(height: 8.0),
        AnimatedContainer(
          duration: duration,
          width: 600,
          decoration: BoxDecoration(
            color: _materialColor[500],
            borderRadius: BorderRadius.circular(8),
            boxShadow: const [
              BoxShadow(
                color: Colors.grey,
                blurRadius: 10.0,
                offset: Offset(5.0, 5.0),
              ),
            ],
          ),
          child: Row(
            children: [
              Expanded(
                child: TextButton(
                  child: Text(
                    'Indicativo',
                    style: GoogleFonts.openSans(
                      textStyle: (_selectedIndex == 0)
                        ? TextStyle(
                            color: const Color(0xFFFFFFFF),
                            fontSize: fontMultiplier * height * 0.001,
                            fontWeight: FontWeight.bold,
                          )
                        : TextStyle(
                            color: const Color(0xFF333333),
                            fontSize: fontMultiplier * height * 0.001,
                          )
                    ),
                  ),
                  onPressed: () {
                    setState(() {
                      _selectedIndex = 0;
                    });
                  }
                )
              ),
              Expanded(
                child: TextButton(
                  child: Text(
                    'Hipotético',
                    style: GoogleFonts.openSans(
                        textStyle: (_selectedIndex == 1)
                            ? TextStyle(
                          color: const Color(0xFFFFFFFF),
                          fontSize: fontMultiplier * height * 0.001,
                          fontWeight: FontWeight.bold,
                        )
                            : TextStyle(
                          color: const Color(0xFF333333),
                          fontSize: fontMultiplier * height * 0.001,
                        )
                    ),
                  ),
                  onPressed: () {
                    setState(() {
                      _selectedIndex = 1;
                    });
                  }
                ),
              ),
              Expanded(
                child: TextButton(
                  child: Text(
                    'Imperativo',
                    style: GoogleFonts.openSans(
                        textStyle: (_selectedIndex == 2)
                            ? TextStyle(
                          color: const Color(0xFFFFFFFF),
                          fontSize: fontMultiplier * height * 0.001,
                          fontWeight: FontWeight.bold,
                        )
                            : TextStyle(
                          color: const Color(0xFF333333),
                          fontSize: fontMultiplier * height * 0.001,
                        )
                    ),
                  ),
                  onPressed: () {
                    setState(() {
                      _selectedIndex = 2;
                    });
                  }
                ),
              ),
            ]
          )
        ),
        const SizedBox(height: 16.0),

        // Tabla
        Container(
          decoration: const BoxDecoration(
            // borderRadius: BorderRadius.circular(8),
            boxShadow: [
              BoxShadow(
                color: Colors.grey,
                blurRadius: 10.0,
                offset: Offset(5.0, 5.0),
              ),
            ],
          ),
          child: FittedBox(
            child: SizedBox(
              width: width * 4 / 5,
              child: Row(
                children: [
                  // Primera columna
                  Column(
                    children: [
                      AnimatedContainer(
                        duration: duration,
                        height: tileHeight,
                        width: tileWidth,
                        color: _materialColor[700],
                        child: Center(
                          child: Text(
                            "Persona",
                            style: GoogleFonts.openSans(
                              textStyle: TextStyle(
                                color: const Color(0xFF333333),
                                fontSize: fontMultiplier * height * 0.001,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
                      AnimatedContainer(
                        duration: duration,
                        height: 3 * tileHeight,
                        width: tileWidth,
                        color: _materialColor[400],
                        child: Center(
                          child: Text(
                            "1°",
                            style: GoogleFonts.openSans(
                              textStyle: TextStyle(
                                color: const Color(0xFF333333),
                                fontSize: fontMultiplier * height * 0.001,
                              ),
                            ),
                          ),
                        ),
                      ),
                      AnimatedContainer(
                        duration: duration,
                        height: 3 * tileHeight,
                        width: tileWidth,
                        color: _materialColor[500],
                        child: Center(
                          child: Text(
                            "2°",
                            style: GoogleFonts.openSans(
                              textStyle: TextStyle(
                                color: const Color(0xFF333333),
                                fontSize: fontMultiplier * height * 0.001,
                              ),
                            ),
                          ),
                        ),
                      ),
                      AnimatedContainer(
                        duration: duration,
                        height: 3 * tileHeight,
                        width: tileWidth,
                        color: _materialColor[600],
                        child: Center(
                          child: Text(
                            "3°",
                            style: GoogleFonts.openSans(
                              textStyle: TextStyle(
                                color: const Color(0xFF333333),
                                fontSize: fontMultiplier * height * 0.001,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),

                  // Segunda columna
                  Column(
                    children: [
                      AnimatedContainer(
                        duration: duration,
                        height: tileHeight,
                        width: tileWidth,
                        color: _materialColor[700],
                        child: Center(
                          child: Text(
                            "Número",
                            style: GoogleFonts.openSans(
                              textStyle: TextStyle(
                                color: const Color(0xFF333333),
                                fontSize: fontMultiplier * height * 0.001,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
                      ...List.generate(3, (i) {
                        return Column(
                          children: [
                            AnimatedContainer(
                              duration: duration,
                              height: tileHeight,
                              width: tileWidth,
                              color: _materialColor[100],
                              child: Center(
                                child: Text(
                                  "Singular",
                                  style: GoogleFonts.openSans(
                                    textStyle: TextStyle(
                                      color: const Color(0xFF333333),
                                      fontSize: fontMultiplier * height * 0.001,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            AnimatedContainer(
                              duration: duration,
                              height: tileHeight,
                              width: tileWidth,
                              color: _materialColor[200],
                              child: Center(
                                child: Text(
                                  "Dual",
                                  style: GoogleFonts.openSans(
                                    textStyle: TextStyle(
                                      color: const Color(0xFF333333),
                                      fontSize: fontMultiplier * height * 0.001,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            AnimatedContainer(
                              duration: duration,
                              height: tileHeight,
                              width: tileWidth,
                              color: _materialColor[300],
                              child: Center(
                                child: Text(
                                  "Plural",
                                  style: GoogleFonts.openSans(
                                    textStyle: TextStyle(
                                      color: const Color(0xFF333333),
                                      fontSize: fontMultiplier * height * 0.001,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        );
                      }),
                    ],
                  ),

                  // Tercera columna
                  Expanded(
                    child: Column(
                      children: [
                        AnimatedContainer(
                          duration: duration,
                          height: tileHeight,
                          color: _materialColor[700],
                          child: Center(
                            child: Text(
                              "Conjugación",
                              style: GoogleFonts.openSans(
                                textStyle: TextStyle(
                                  color: const Color(0xFF333333),
                                  fontSize: fontMultiplier * height * 0.001,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ),

                        ...List.generate(9, (i) {
                          Color? color;
                          if (i % 3 == 0) {
                            color = Colors.white;
                          }
                          else if (i % 3 == 1) {
                            color = Colors.grey[100];
                          }
                          else {
                            color = Colors.grey[200];
                          }

                          return AnimatedContainer(
                            duration: duration,
                            height: tileHeight,
                            color: color,
                            child: Center(
                              child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text(
                                      persons[i],
                                      style: GoogleFonts.openSans(
                                        textStyle: TextStyle(
                                          color: const Color(0xFF888888),
                                          fontSize: fontMultiplier * height * 0.0007,
                                        ),
                                      ),
                                    ),
                                    Text(
                                      _conjugations[_selectedIndex][i],
                                      style: GoogleFonts.openSans(
                                        textStyle: TextStyle(
                                          color: const Color(0xFF333333),
                                          fontSize: fontMultiplier * height * 0.001,
                                        ),
                                      ),
                                    ),
                                  ]
                              ),
                            ),
                          );
                        }),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ]
    );
  }
}
