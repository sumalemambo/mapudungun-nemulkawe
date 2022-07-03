import 'package:flutter/material.dart';
import 'details.dart';

class AboutCard extends StatelessWidget {
  const AboutCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Column(
        children: <Widget>[
          Container(height: 50),
          Container(
              width: 180,
              height: 50 ,
              child: ElevatedButton(
                child: const Text(
                    "Bibliografía",
                    style: TextStyle(
                      fontFamily: 'Avenir',
                      fontSize: 28,
                      color: Colors.white,
                      fontWeight: FontWeight.w400,
                    )
                ),
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
                            borderRadius: BorderRadius.circular(100),
                        )
                    )
                ),
              )),
        ],
      ),
    );
  }
}