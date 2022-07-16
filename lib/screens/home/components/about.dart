import 'package:flutter/material.dart';
import 'details.dart';


class AboutCard extends StatelessWidget {
  AboutCard({Key? key}) : super (key: key);
  @override
  Widget build(BuildContext context) {
    final Width = MediaQuery.of(context).size.width;
    return SizedBox(
      child: Column(
        children: <Widget>[
          Container(
              decoration: BoxDecoration(
                color: Colors.blue,
                borderRadius: BorderRadius.circular(100),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 5,
                    blurRadius: 7,
                    offset: const Offset(0,3),
                  )
                ]
              ),
              width: Width * 0.1,
              height: Width * 0.1,
              child: IconButton(
                icon: Icon(Icons.question_mark_rounded, size: Width * 0.05, color: Colors.white,),
                  onPressed: () {Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const AboutDetails(),
            ),
          );},)),
        ],
      ),
    );
  }
}