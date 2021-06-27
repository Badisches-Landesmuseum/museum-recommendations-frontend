import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

Future<MuseumObject> fetchMuseumObject({String inventoryNum = ""}) async {
  String uri = 'http://127.0.0.1:8000/data/';
  if (inventoryNum != "") {
    uri = uri + inventoryNum;
  } else {
    uri = uri + "MK_4991";
  }
  final response =
  await http.get(Uri.parse(uri));

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

class Feedback {
  final int userId;
  final int metricJoy;
  final int metricEmpathy;
  final int metricThoughtfulness;

  Feedback({
    required this.userId,
    required this.metricJoy,
    required this.metricEmpathy,
    required this.metricThoughtfulness
  });
}

// меняет профайл
Future<List<MuseumObject>> getNextObject(String obj_id, String joi, String empathy, String thoughtfulness) async {
  final predictions_response =
      await http.post(
        Uri.parse('http://127.0.0.1:8000/user_score'),
        headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{

        'object_id': obj_id,
        'joi': joi,
        'empathy': empathy,
        'thoughtfulness': thoughtfulness
        })
      );

  if (predictions_response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    dynamic json = jsonDecode(predictions_response.body);
    List<MuseumObject> objects = [];
    for (var i = 0; i < json["recommendations"].length; i++) {
      MuseumObject object = await fetchMuseumObject(inventoryNum: json["recommendations"][i]);
      objects.add(object);
    }

    return objects;

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


