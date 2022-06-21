import 'package:flutter/material.dart';
import 'main.dart';
import 'package:intl/intl.dart';

var now = DateTime.now();
var formatter = DateFormat.yMMMd('en_US');
String today = formatter.format(now);

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
          child: Column(
            children: [
              Padding(padding: const EdgeInsets.all(15.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Container(
                        width: 120,
                        height: 25,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(15),
                            boxShadow: const [
                              BoxShadow(
                                  color: Colors.grey ,
                                  blurRadius: 10.0,
                                  offset: Offset(5.0,5.0)
                              )
                            ]
                        ),
                        child: Align(
                          alignment: Alignment.center,
                          child: Text(
                              today,
                            style: const TextStyle(
                              color: Colors.black,
                              fontSize: 20.0,
                              fontWeight: FontWeight.w600,
                            ),
                            textScaleFactor: 0.8,
                          ),
                        )
                    ),
                  ],
                ),

              ),
              Padding(padding: const EdgeInsets.all(15.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                        width: 250,
                        height: 80,
                        decoration: BoxDecoration(
                            color: Colors.blue,
                            borderRadius: BorderRadius.circular(8),
                            boxShadow: const [
                              BoxShadow(
                                  color: Colors.grey ,
                                  blurRadius: 10.0,
                                  offset: Offset(5.0,5.0)
                              )
                            ]
                        ),
                        child: const Align(
                          alignment: Alignment.center,
                          child: Text(
                            'Palabra del día',
                            style: TextStyle(
                              fontFamily: 'Avenir',
                              fontSize: 30,
                              color: Colors.white,
                              fontWeight: FontWeight.w900,
                            ),
                          ),
                        )
                    ),
                  ],
                ),

              ),
              const Main(),

            ],
          )
      ),
    );
  }
}