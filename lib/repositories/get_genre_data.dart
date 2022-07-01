import 'dart:convert';

import 'package:http/http.dart';
import 'package:neptune_music/api/url.dart';
import 'package:neptune_music/methods/get_response.dart';
import 'package:neptune_music/models/artist_model.dart';
import 'package:neptune_music/models/song_model.dart';

class GenreRepository {
  Future<List<ArtistModel>> getArtists(String tag) async {
    final query = {
      "page": 0.toString(),
      "limit": 50.toString(),
    };

    Response res = await getResponse(
        Uri.http(baseUrl, basePath + '/tags/artists/' + tag, query));
    if (res.statusCode == 200) {
      var body = jsonDecode(res.body);
      return (body['results'] as List)
          .map((e) => ArtistModel.fromJson(e))
          .toList();
    } else {
      throw Exception("failed fetch users ");
    }
  }

  Future<List<SongModel>> getSongs(String tag) async {
    final query = {
      "page": 0.toString(),
      "limit": 50.toString(),
    };

    Response res =
        await getResponse(Uri.http(baseUrl, basePath + '/tags/' + tag, query));
    if (res.statusCode == 200) {
      var body = jsonDecode(res.body);

      return (body['results'] as List)
          .map((e) => SongModel.fromJson(e))
          .toList();
    } else {
      throw Exception("failed fetch users ");
    }
  }
}
