part of 'home_cubit.dart';

class HomeState {
  final LoadPage status;
  final List<ArtistModel> artists;
  final List<SongModel> songs;
  HomeState({
    required this.status,
    required this.artists,
    required this.songs,
  });
  factory HomeState.initial() {
    return HomeState(
      songs: [],
      status: LoadPage.initial,
      artists: [],
    );
  }

  HomeState copyWith({
    LoadPage? status,
    List<ArtistModel>? artists,
    List<SongModel>? songs,
  }) {
    return HomeState(
      status: status ?? this.status,
      artists: artists ?? this.artists,
      songs: songs ?? this.songs,
    );
  }
}
