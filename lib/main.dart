import 'package:card_animation/card_view.dart';
import 'package:card_animation/var_card.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  List<VarCard> datacard = [
    VarCard("Rezza", "+6- 8194495321x", "ilmi--@gmail.com", "007042", 0, 600),
    VarCard("Nuur", "+6- 819449532xx", "rezza--@gmail.com", "1F4690", 70, 500),
    VarCard("Ilmi", "+62 81944953214", "rezza.ilmi@gmail.com", "BE955B", 140, 100),
  ];

  var cardsHeight = 181.0;
  var overlappingDistance = 70.0;

  /// duration for the last card to exit
  var lastCardSpeed = 400;

  /// Max Y point of canvas so the card will invisible
  var maxYPoint     = 400.0;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 50),
            width: double.infinity,
            height: double.infinity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                cardStack(),
                Expanded(child: Container()),
                const Text("Card Animation")
              ],
            )
        ),
      )
    );
  }



  Widget cardStack(){
    return SizedBox(
        width: double.infinity,
        height: cardsHeight + ((datacard.length -1) * overlappingDistance),
        child: GestureDetector(
          behavior:HitTestBehavior.translucent,
          onVerticalDragStart: (details){
            shuffleCards();
          },
          child: Stack(
            children: datacard.asMap().map((i, e) =>
                MapEntry(i,
                    AnimatedPositioned(
                        top: e.position ,
                        left: 0,
                        right: 0,
                        duration: Duration(milliseconds: e.duration),
                        child: CardView(data: e, cardHeight: cardsHeight)
                    ))
            ).values.toList(),
          ),
        )
    );
  }


  void shuffleCards(){
    // count each card position and movement duration
    for(var i = 0 ; i < datacard.length ; i++){
      datacard[i].position = i ==  datacard.length - 1 ? maxYPoint : overlappingDistance * (i + 1);
      datacard[i].duration = i ==  datacard.length - 1 ? lastCardSpeed : ((datacard.length - 1 - i) * 200);
      setState(() {});
    }

    Future.delayed(const Duration(milliseconds: 500), () {
      // change the positions of the last card in array to the first index
      List<VarCard> tempdatacard = [];
      var last = datacard[datacard.length-1];
      last.position = 0;
      last.duration = 200;
      tempdatacard.add(last);

      // change the order of other cards as well
      for(var i = 0 ; i < datacard.length-1 ; i++){
        var card = datacard[i];
        card.position = 70 * (i+1);
        card.duration = 0;
        tempdatacard.add(card);
      }
      datacard = tempdatacard;
      setState((){});
    });
  }


}
