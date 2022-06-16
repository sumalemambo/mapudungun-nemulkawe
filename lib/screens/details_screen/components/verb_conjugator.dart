import 'package:flutter/material.dart';


final persons = ["iñche", "iñchiw", "iñchiñ", "eymi", "eymu", "eymün", "fey", "fey egu", "fey egün"];

final endingsVowel = [
  "n", "li", "chi",
  "yu", "liyu", "yu",
  "iñ", "liyiñ", "iñ",
  "ymi", "lmi", "ge",
  "ymu", "lmu", "mu",
  "ymün", "lmün", "mün",
  "y", "le", "pe",
  "y egu", "le egu", "pe egu",
  "y egün", "le egün", "pe egün",
];

final endingsI = [
  "n", "li", "chi",
  "yu", "liyu", "yu",
  "yiñ", "liyiñ", "yiñ",
  "mi", "lmi", "ge",
  "mu", "lmu", "mu",
  "mün", "lmün", "mün",
  "", "le", "pe",
  " egu", "le egu", "pe egu",
  " egün", "le egün", "pe egün",
];

final endingsConsonant = [
  "ün", "li", "chi",
  "iyu", "liyu", "yu",
  "iyiñ", "liyiñ", "iñ",
  "imi", "ülmi", "ge",
  "imu", "ülmu", "mu",
  "imün", "ülmün", "mün",
  "i", "le", "pe",
  "i egu", "le egu", "pe egu",
  "i egün", "le egün", "pe egün",
];

class VerbConjugator extends StatelessWidget {
  const VerbConjugator({Key? key}) : super(key: key);

  List<String> conjugate(String s) {
    s = s.substring(0, s.length-1);

    List<String> vowelsWithoutI = ["a", "ü", "e", "o", "u"];
    List<String> endings;
    if (vowelsWithoutI.any((vowel) => s.endsWith(vowel))) {
      endings = endingsVowel;
    }
    else if (s.endsWith("i")) {
      endings = endingsI;
    }
    else {
      endings = endingsConsonant;
    }

    var conjugations = endings.map((ending) => s + ending).toList();
    return conjugations;
  }

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      crossAxisCount: 3,
      children: conjugate("zewma-").map((verb) => Text(verb)).toList(),
      shrinkWrap: true,
    );
  }
}
