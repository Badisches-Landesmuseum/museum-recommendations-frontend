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
      "The Last Supper portrays the reaction given by each apostle when Jesus said one of them would betray him. All twelve apostles have different reactions to the news, with various degrees of anger and shock. The apostles were identified by their names, using an unsigned, mid-sixteenth-century fresco copy of Leonardo's Cenacolo.";
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
          Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
            Row(children: [
              star1,
              Text('  Joy'),
            ]),
            Row(children: [
              star2,
              Text('  Empathy'),
            ]),
            Row(children: [
              star3,
              Text('  Thoughtfulness'),
            ]),
          ]),
          ElevatedButton(
            onPressed: () {
              debugPrint("Ranking changed: " + star1.getRating().toString());
              star1.getRating();
            },
            child: Text('Submit'),
          ),
          Text(
            'Recommendations:',
            style: TextStyle(fontSize: 18),
          ),
          SizedBox(
            height: 200.0,
            child: ListView.builder(
              physics: ClampingScrollPhysics(),
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              itemCount: 15,
              itemBuilder: (BuildContext context, int index) => Card(
                child: Center(child: Text('Recommendation card')),
              ),
            ),
          ),
        ])));
  }

  Widget _rankings() {
    return new TestStar();
  }

  Container _image() {
    return new Container(
      color: Colors.grey[200],
      child: new Image.asset('assets/MK_1000.jpg'),
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
