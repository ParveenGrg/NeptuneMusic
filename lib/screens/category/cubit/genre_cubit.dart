import 'package:bloc/bloc.dart';
import 'package:neptune_music/controller/main_controller.dart';
import 'package:neptune_music/models/loading_enum.dart';
import 'package:neptune_music/models/song_model.dart';
import 'package:neptune_music/models/artist_model.dart';
import 'package:neptune_music/repositories/get_genre_data.dart';

part 'genre_state.dart';

class GenreCubit extends Cubit<GenreState> {
  final repo = GenreRepository();

  GenreCubit() : super(GenreState.initial());
  void init(String tag) async {
    try {
      emit(state.copyWith(status: LoadPage.loading));
      var artists = await repo.getArtists(tag);
      var songs = await repo.getSongs(tag);
      emit(state.copyWith(
        status: LoadPage.loaded,
        artists: artists,
        songs: songs,
      ));
    } catch (e) {
      emit(state.copyWith(status: LoadPage.error));
    }
  }

  void playSongs(MainController controller, int initial) {
    controller.playSong(controller.convertToAudio(state.songs), initial);
  }
}
