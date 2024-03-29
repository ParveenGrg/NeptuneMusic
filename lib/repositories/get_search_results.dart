import 'dart:convert';

import 'package:http/http.dart';
import 'package:neptune_music/api/url.dart';
import 'package:neptune_music/methods/get_response.dart';
import 'package:neptune_music/models/artist_model.dart';
import 'package:neptune_music/models/song_model.dart';

class SearchRepository {
  Future<List<ArtistModel>> getArtists(String tag) async {
    final query = {
      "page": 0.toString(),
      "limit": 50.toString(),
      "q": tag,
    };

    Response res = await getResponse(
        Uri.http(baseUrl, basePath + '/search/artists', query));
    if (res.statusCode == 200) {
      var body = jsonDecode(res.body);
      return (body['results'] as List)
          .map((e) => ArtistModel.fromJson(e))
          .toList();
    } else {
      throw Exception("failed fetch artists");
    }
  }

  Future<List<SongModel>> getSongs(String tag) async {
    final query = {
      "page": 0.toString(),
      "limit": 50.toString(),
      "q": tag,
    };

    Response res =
        await getResponse(Uri.http(baseUrl, basePath + '/search/songs', query));
    if (res.statusCode == 200) {
      var body = jsonDecode(res.body);

      return (body['results'] as List)
          .map((e) => SongModel.fromJson(e))
          .toList();
    } else {
      throw Exception("failed fetch songs");
    }
  }
}
