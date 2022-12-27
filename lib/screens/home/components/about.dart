import 'package:app/screens/about/components/about.dart';
import 'package:flutter/material.dart';
import 'details.dart';


class AboutCard extends StatelessWidget {
  const AboutCard({Key? key}) : super (key: key);

  @override
  Widget build(BuildContext context) {
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
              width: 40.0,
              height: 40.0,
              child: IconButton(
                icon: const Icon(
                  Icons.question_mark_rounded,
                  color: Colors.white,
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const Abb()),
                  );
                },
              ),
          ),
        ],
      ),
    );
  }
}