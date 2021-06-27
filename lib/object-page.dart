import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:frontend/stars.dart';
import 'package:flutter/foundation.dart';


class ObjectPage extends StatelessWidget {
  String value;
  ObjectPage({required this.value});
  TestStar star1 = new TestStar();
  TestStar star2 = new TestStar();
  TestStar star3 = new TestStar();
  String testText = "testText";

  String description =
      "Sammelname für Legierungen, die neben Kupfer (ca. 60 %) überwiegend aus Zinn bestehen. Bronze wurde bereits in vorgeschichtlicher Zeit (Bronzezeit) für Geräte, Plastiken, Schmuck und Waffen verwendet. Ab einem Anteil von 10 % Zinn ist die gute Gießbarkeit der Bronze gewährleistet, es verringert sich aber die Elastizität und die Schmiedbarkeit. Gute geschmiedete Bronze-Klingen enthalten meist nicht mehr als 4 % Zinn. Bei höherem Zinnanteil wurde schon in der Bronzezeit Arsen als Legierungsbestandteil beigemengt, um die Härte zu erhöhen.";
  @override
  Widget build(BuildContext context) {

    return Scaffold(
        body: SingleChildScrollView(
            child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  _image(),
                  _description(),
                  star1,
                  star2,
                  star3,
                  ElevatedButton(
                    onPressed: () {
                      debugPrint("Ranking changed: " + star1.getRating().toString());
                      star1.getRating();
                    },
                    child: Text('Submit'),
                  ),
                ])));
  }

  Widget _rankings() {
    return new TestStar();
  }

  Container _image() {
    return new Container(
      color: Colors.grey[200],
      child: new Image.asset('assets/MK_4991.jpg'),
      alignment: Alignment.center,
    );
  }

  Container _description() {
    return Container(
      padding: const EdgeInsets.all(32),
      child: Text(
        description,
        softWrap: true,
      ),
    );
  }

  Center buildObjectPage() {
    return Center(
        child: Text(
      value,
    ));
  }
}
