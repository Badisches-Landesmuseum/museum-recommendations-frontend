import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ObjectPage extends StatelessWidget {
  String value;
  ObjectPage({required this.value});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          value,
        ),
      ),
    );
  }
}