import 'dart:convert';

import 'package:neptune_music/api/url.dart';
import 'package:neptune_music/methods/get_response.dart';
import 'package:neptune_music/models/artist_model.dart';
import 'package:neptune_music/models/song_model.dart';

class GetArtistsData {
  Future<ArtistModel> getArtistData(String id) async {
    final value =
        await getResponse(Uri.http(baseUrl, basePath + '/artist/' + id));

    if (value.statusCode == 200) {
      final body = jsonDecode(value.body);

      return ArtistModel.fromJson(body['results']);
    } else {
      throw Exception('Failed to load data');
    }
  }

  Future<List<SongModel>> getSongs(String id) async {
    final value =
        await getResponse(Uri.http(baseUrl, basePath + '/songs/' + id, {
      "page": 0.toString(),
      "limit": 100.toString(),
    }));
    if (value.statusCode == 200) {
      final body = jsonDecode(value.body);
      return ((body['results'] as List)
          .map((e) => SongModel.fromJson(e))
          .toList());
    } else {
      throw Exception('Failed to load data');
    }
  }
}
