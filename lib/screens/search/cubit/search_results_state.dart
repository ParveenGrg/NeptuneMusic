part of 'search_results_cubit.dart';

class SearchResultsState {
  final LoadPage status;
  final List<SongModel> songs;
  final List<ArtistModel> artists;
  final bool isSong;
  final bool isNull;
  SearchResultsState({
    required this.status,
    required this.songs,
    required this.artists,
    required this.isSong,
    required this.isNull,
  });

  factory SearchResultsState.initial() => SearchResultsState(
        songs: [],
        artists: [],
        isNull: true,
        isSong: true,
        status: LoadPage.initial,
      );

  SearchResultsState copyWith({
    LoadPage? status,
    List<SongModel>? songs,
    List<ArtistModel>? artists,
    bool? isSong,
    bool? isNull,
  }) {
    return SearchResultsState(
      status: status ?? this.status,
      songs: songs ?? this.songs,
      artists: artists ?? this.artists,
      isSong: isSong ?? this.isSong,
      isNull: isNull ?? this.isNull,
    );
  }
}
