import 'dart:convert';
import 'dart:math';
import 'package:http/http.dart';
import 'package:neptune_music/api/url.dart';
import 'package:neptune_music/methods/get_response.dart';
import 'package:neptune_music/models/artist_model.dart';
import 'package:neptune_music/models/song_model.dart';

class GetHomePage {
  Future<List<SongModel>> getSongs() async {
    final query = {"limit": 30.toString()};
    final value = await getResponse(Uri.http(
      baseUrl,
      basePath + '/songs/random/all',
      query,
    ));
    if (value.statusCode == 200) {
      final body = jsonDecode(value.body);

      final songs = (body['results'] as List)
          .map((user) => SongModel.fromJson(user))
          .toList();
      //print(songs[0]);
      return songs;
    } else {
      throw Exception('Failed to load songs');
    }
  }

  Future<List<ArtistModel>> getArtists() async {
    final query = {
      "page": (Random().nextInt(8)).toString(),
      "limit": 26.toString()
    };
    Response res =
        await getResponse(Uri.http(baseUrl, basePath + '/artists', query));
    if (res.statusCode == 200) {
      final body = jsonDecode(res.body);

      final artists = (body['results'] as List)
          .map<ArtistModel>((artists) => ArtistModel.fromJson(artists))
          .toList();
      //print(artists[0]);
      return artists;
    } else {
      throw Exception('Failed to load artists');
    }
  }
}
