import 'package:card_animation/var_card.dart';
import 'package:flutter/material.dart';

class CardView extends StatelessWidget {
  CardView({Key? key, required this.data, required this.cardHeight}): super(key: key);

  final VarCard data;
  final double cardHeight;

  @override
  Widget build(BuildContext context) {
    return Container(
        width: double.infinity,
        height: cardHeight,
        padding:  const EdgeInsets.symmetric(horizontal: 25, vertical: 15),
        decoration: BoxDecoration(
            color: hexStringToColor(data.backgroundColor),
            borderRadius: BorderRadius.circular(10),
            boxShadow:  [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                spreadRadius: 3,
                blurRadius: 3,
                offset: const Offset(0, 2), // changes position of shadow
              ),
            ]
        ),
        child: Column(
          children: [
            Container(
              alignment: Alignment.centerLeft,
              child: Text(data.cardname, style: const TextStyle(fontSize: 18, color: Colors.white, height: 1.4, fontWeight: FontWeight.w700)),
            ),
            const SizedBox(height: 5),
            Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const Icon(Icons.email, size: 15, color: Colors.white),
                  const SizedBox(width: 5),
                  Text(data.email, style: const TextStyle(fontSize: 14, color: Colors.white, fontWeight: FontWeight.w400)),
                ]
            ),
            const SizedBox(height: 10),
            Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const Icon(Icons.phone, size: 15, color: Colors.white),
                  const SizedBox(width: 5),
                  Text(data.phonenumber, style: const TextStyle(fontSize: 14, color: Colors.white, fontWeight: FontWeight.w400)),
                ]
            ),
          ],
        )
    );
  }

  hexStringToColor(String hexColor) {
    hexColor = hexColor.toUpperCase().replaceAll("#", "");
    if (hexColor.length == 6) {
      hexColor = "0xff$hexColor";
    }
    return Color(int.parse(hexColor));
  }

}