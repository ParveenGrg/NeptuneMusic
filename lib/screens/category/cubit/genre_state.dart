part of 'genre_cubit.dart';

class GenreState {
  final LoadPage status;
  final List<SongModel> songs;
  final List<ArtistModel> artists;
  GenreState({
    required this.status,
    required this.songs,
    required this.artists,
  });

  factory GenreState.initial() =>
      GenreState(songs: [], artists: [], status: LoadPage.initial);

  GenreState copyWith({
    LoadPage? status,
    List<SongModel>? songs,
    List<ArtistModel>? artists,
  }) {
    return GenreState(
      status: status ?? this.status,
      songs: songs ?? this.songs,
      artists: artists ?? this.artists,
    );
  }
}
