import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ObjectPage extends StatelessWidget {
  String value;
  ObjectPage({required this.value});

  String description = "Sammelname für Legierungen, die neben Kupfer (ca. 60 %) überwiegend aus Zinn bestehen. Bronze wurde bereits in vorgeschichtlicher Zeit (Bronzezeit) für Geräte, Plastiken, Schmuck und Waffen verwendet. Ab einem Anteil von 10 % Zinn ist die gute Gießbarkeit der Bronze gewährleistet, es verringert sich aber die Elastizität und die Schmiedbarkeit. Gute geschmiedete Bronze-Klingen enthalten meist nicht mehr als 4 % Zinn. Bei höherem Zinnanteil wurde schon in der Bronzezeit Arsen als Legierungsbestandteil beigemengt, um die Härte zu erhöhen.";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: new Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            color: Colors.grey[200],
            child: new Image.asset('assets/MK_4991.jpg'),
            alignment: Alignment.center,
          ),
          Container(
            padding: const EdgeInsets.all(32),
            child: Text(
              description,
              softWrap: true,
            ),
          )
        ]
      )
    );
  }

  Center buildObjectPage() {
    return Center(
      child: Text(
        value,
      )
    );
  }
}