import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

Future<MuseumObject> fetchMuseumObject() async {
  final response =
  await http.get(Uri.parse('http://127.0.0.1:8000/data/MK_4991'));

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    return MuseumObject.fromJson(jsonDecode(response.body));
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load object');
  }
}

// Future<Image> fetchMuseumObjectImage(String uri) async {
//   final response =
//   await http.get(Uri.parse(uri));
//
//   if (response.statusCode == 200) {
//     // If the server did return a 200 OK response,
//     // then parse the JSON.
//     return MuseumObject.fromJson(json);
//   } else {
//     // If the server did not return a 200 OK response,
//     // then throw an exception.
//     throw Exception('Failed to load object');
//   }
// }

class MuseumObject {
  final String inventoryNum;
  final String title;
  Image? image;
  Map<String, dynamic> jsonEncoded;

  MuseumObject({
    required this.inventoryNum,
    required this.title,
    required this.jsonEncoded
  });

  factory MuseumObject.fromJson(Map<String, dynamic> json) {
    // if (json["image"] != "") {
    //   MuseumObject object = MuseumObject(
    //       inventoryNum: json['inventory_num'],
    //       title: json['title'],
    //       jsonEncoded: json,
    //   );
    //   object.image = fetchMuseumObjectImage(json["image"]);
    //       return object;
    // } else {
      return MuseumObject(
          inventoryNum: json['inventory_num'],
          title: json['title'],
          jsonEncoded: json
      );
    // }
  }


}