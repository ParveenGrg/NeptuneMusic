part of 'artist_profile_cubit.dart';

class ArtistProfileState {
  final ArtistModel artist;
  final LoadPage status;
  final List<SongModel> songs;
  ArtistProfileState({
    required this.artist,
    required this.status,
    required this.songs,
  });
  factory ArtistProfileState.initial() {
    return ArtistProfileState(
      artist: ArtistModel(),
      songs: [],
      status: LoadPage.initial,
    );
  }

  ArtistProfileState copyWith({
    ArtistModel? artist,
    LoadPage? status,
    List<SongModel>? songs,
  }) {
    return ArtistProfileState(
      artist: artist ?? this.artist,
      status: status ?? this.status,
      songs: songs ?? this.songs,
    );
  }
}
