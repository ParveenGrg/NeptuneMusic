import 'package:bloc/bloc.dart';
import 'package:neptune_music/controller/main_controller.dart';
import 'package:neptune_music/models/artist_model.dart';
import 'package:neptune_music/models/loading_enum.dart';
import 'package:neptune_music/repositories/get_search_results.dart';
import 'package:neptune_music/models/song_model.dart';

part 'search_results_state.dart';

class SearchResultsCubit extends Cubit<SearchResultsState> {
  final repo = SearchRepository();

  SearchResultsCubit() : super(SearchResultsState.initial());
  void searchSongs(String tag) async {
    if (state.isSong) {
      try {
        emit(state.copyWith(status: LoadPage.loading));
        var songs = await repo.getSongs(tag.toString());
        emit(state.copyWith(
          status: LoadPage.loaded,
          songs: songs,
        ));
      } catch (e) {
        emit(state.copyWith(status: LoadPage.error));
      }
    } else {
      try {
        emit(state.copyWith(status: LoadPage.loading));
        var artists = await repo.getArtists(tag.toString());
        emit(state.copyWith(
          status: LoadPage.loaded,
          artists: artists,
        ));
      } catch (e) {
        emit(state.copyWith(status: LoadPage.error));
      }
    }
  }

  void playSongs(MainController controller, int initial) {
    controller.playSong(controller.convertToAudio(state.songs), initial);
  }

  void isNullToggle() {
    emit(state.copyWith(isNull: !state.isNull));
  }

  void isSongToggle() {
    emit(state.copyWith(isSong: !state.isSong));
  }
}
