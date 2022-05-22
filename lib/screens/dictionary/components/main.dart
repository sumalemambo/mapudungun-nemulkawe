import 'package:flutter/material.dart';
import 'package:app/global_var.dart';

class Main extends StatefulWidget {
  const Main({Key? key}) : super(key: key);

  @override
  State<Main> createState() => _MainState();
}

class _MainState extends State<Main> {

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 500.0,
        child: Card(
          margin: EdgeInsets.fromLTRB(16, 16, 16, 0),
          elevation: 4.0,
          child: ListView.builder(
            itemCount: data['mapuzuguletuain']!.length - 1,
            itemBuilder: (context, i) {
              return Card(
                child: ListTile(
                  leading: Text(data['mapuzuguletuain']![i+1][0].toString()),
                  title: Text(data['mapuzuguletuain']![i+1][2].toString()),
                  subtitle: Text(data['mapuzuguletuain']![i+1][3].toString()),
                  trailing: Icon(Icons.favorite),
                ),
              );
            },
          ),
        )
    );
  }
}
