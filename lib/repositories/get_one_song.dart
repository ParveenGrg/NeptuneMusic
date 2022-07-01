import 'dart:convert';

import 'package:http/http.dart';
import 'package:neptune_music/api/url.dart';
import 'package:neptune_music/methods/get_response.dart';
import 'package:neptune_music/models/song_model.dart';

class GetOneSong {
  Future<SongModel> getSongs(String name) async {
    Response res =
        await getResponse(Uri.http(baseUrl, basePath + '/songs/one/' + name));
    if (res.statusCode == 200) {
      var body = jsonDecode(res.body);

      return SongModel.fromJson(body['results'][0]);
    } else {
      throw Exception("failed fetch users ");
    }
  }
}
