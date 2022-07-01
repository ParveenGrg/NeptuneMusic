import 'dart:convert';

import 'package:neptune_music/api/url.dart';
import 'package:neptune_music/models/error_model.dart';
import 'package:neptune_music/repositories/generate_user_id.dart';
import 'package:http/http.dart' as http;

class GetNotifications {
  Future<List<dynamic>> getNotifications(String id) async {
    // print(id.toLowerCase());
    var res = await http.get(
        Uri.parse(
          baseUrl + basePath + '/notifications/' + genrateId(id),
        ),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        });
    // print(res.statusCode);
    if (res.statusCode == 200) {
      return (jsonDecode(res.body)['results'] as List);
    } else {
      throw ErrorModel(code: "404", message: 'Something wents wrong.');
    }
  }

  Future<bool> deleteNotifications(String userId) async {
    var res = await http.delete(
        Uri.parse(
          baseUrl + basePath + '/notifications/${genrateId(userId)}',
        ),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        });
    // print(res.statusCode);
    if (res.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }
}
