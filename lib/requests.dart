import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

Future<MuseumObject> fetchMuseumObject() async {
  final response =
  await http.get(Uri.parse('http://127.0.0.1:8000/data/MK_4991'));

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    dynamic json = jsonDecode(response.body);
    MuseumObject object = MuseumObject.fromJson(json);
    if (json["image_url"] != '') {
      object.image = await fetchMuseumObjectImage(json["image_url"]);
    }
    // TODO: save scanObjectNum
    return object;
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load object');
  }
}

// меняет профайл
Future<MuseumObject> getNextObject(String joi, String empathy, String thoughtfulness) async {
  final response =
      await http.post(
        Uri.parse('http://127.0.0.1:8000/user_score'),
        headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
        // TODO: use scanObjectNum
        'object_id': objectId,
        'joi': joi,
        'empathy': empathy,
        'thoughtfulness': thoughtfulness
        })
      );

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    dynamic json = jsonDecode(response.body);
    MuseumObject object = MuseumObject.fromJson(json);
    if (json["image_url"] != '') {
      object.image = await fetchMuseumObjectImage(json["image_url"]);
    }

    return object;
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load object');
  }
}

Future<Image> fetchMuseumObjectImage(String uri) async {
  print("sending request");
  final response = await http.get(Uri.parse(uri));

  print("awaiting response");

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    print("fetched base64");
    dynamic base64Image = response.body;
    Uint8List bytes = base64.decode(base64Image);
    Image image = new Image.memory(bytes);
    print("returning");
    return image;
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load object');
  }
}

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
    MuseumObject object = MuseumObject(
      inventoryNum: json['inventory_num'],
      title: json['title'],
      jsonEncoded: json,
    );
    return object;
  }
}


