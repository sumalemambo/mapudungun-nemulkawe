import 'package:flutter/material.dart';

import 'components/about.dart';
import 'components/date_box.dart';
import 'components/word_of_the_day_title_box.dart';
import 'components/word_of_the_day_card.dart';


class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;

    return Padding(
      padding: EdgeInsets.all(height * 0.025),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [AboutCard(), Spacer(), DateBox()],
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: EdgeInsets.all(height * 0.0225),
                  child: WordOfTheDayTitleBox(height: height,),
                ),
                WordOfTheDayCard(height: height,),
              ],
            ),
          ),
        ],
      ),
    );
  }
}