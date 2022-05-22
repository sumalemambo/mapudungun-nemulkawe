import 'package:app/database/database_helper.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:app/providers/favorites_provider.dart';

import '../../../models/word_model.dart';

class Main extends StatefulWidget {
  const Main({Key? key}) : super(key: key);

  @override
  State<Main> createState() => _MainState();
}

class _MainState extends State<Main> {
  late List<Word> dataList = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();

    loadData();
  }

  void loadData() async {
    var _dataList = await DatabaseHelper.selectAll(Word.table);
    dataList = _dataList
        .map((item) => Word(
        id: item['_id'],
        theme: item['theme'],
        isUnderTheme: item['isUnderTheme'],
        word: item['word'],
        translation: item['translation'],
        definition: item['definition'],
        conjugation: item['conjugation'],
        declensions: item['declensions'],
        examples: item['examples'],
        pronunciation: item['pronunciation']
    )).toList();
    setState(() => isLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Provider.of<FavoritesProvider>(context, listen: false)
          .selectFavoritesIds(),
      builder: (BuildContext context, snapshot) {
        if (snapshot.hasData) {
          if (isLoading == false) {
            return Container(

            );
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        } else {
          return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }

  /*
  Widget build(BuildContext context) {
    return Container(
      color: Colors.amber,
      child: ListView(
          scrollDirection: Axis.vertical,
          shrinkWrap: true,
          children: [
            Container(
              child: Consumer<Greet>(
                builder: (context, myGreet, child) {
                  return ElevatedButton(
                    onPressed: (){
                      myGreet.doGreet('Good Afternon');
                    },
                    child: Text('Greetings'),
                  );
                },
              ),
            ),
            Container(
              child: Consumer<Greet>(
                builder: (context, mygreet, child) {
                  return Text(mygreet.greetings);
                },
              ),
            ),
            Container(
              child: Consumer<Dgreet>(
                builder: (context, dgreet, child) {
                  return ElevatedButton(
                    onPressed: (){
                      dgreet.doAnotherGreet();
                    },
                    child: Text('Another greet'),
                  );
                },
              ),
            ),
            FutureBuilder(
                builder: Provider.of<Dgreet>
            ),
        ],
      )
    );
  }
   */
}

class _AddButton extends StatelessWidget {
  final int item;

  const _AddButton({required this.item});

  @override
  Widget build(BuildContext context) {
    // The context.select() method will let you listen to changes to
    // a *part* of a model. You define a function that "selects" (i.e. returns)
    // the part you're interested in, and the provider package will not rebuild
    // this widget unless that particular part of the model changes.
    //
    // This can lead to significant performance improvements.
    var isInCart = context.select<FavoritesProvider, bool>(
      // Here, we are only interested whether [item] is inside the cart.
          (cart) => cart.itemIds.contains(item)
    );

    return TextButton(
      onPressed: isInCart
          ? null
          : () {
        // If the item is not in cart, we let the user add it.
        // We are using context.read() here because the callback
        // is executed whenever the user taps the button. In other
        // words, it is executed outside the build method.
        var cart = context.read<FavoritesProvider>();
        cart.add(item);
      },
      style: ButtonStyle(
        overlayColor: MaterialStateProperty.resolveWith<Color?>((states) {
          if (states.contains(MaterialState.pressed)) {
            return Theme.of(context).primaryColor;
          }
          return null; // Defer to the widget's default.
        }),
      ),
      child: isInCart
          ? const Icon(Icons.check, semanticLabel: 'ADDED')
          : const Text('ADD'),
    );
  }
}

class Greet extends ChangeNotifier {
  String greetings = 'Good morning';
  List<String> values = [];
  void doGreet(String value) {
    greetings = value;
    values.add('TEST');
    print(values);
    notifyListeners();
  }
}

class Dgreet {
  Greet _myGreet;
  Dgreet(this._myGreet);
  void doAnotherGreet() {
    _myGreet.doGreet('Goodnight');
  }
}