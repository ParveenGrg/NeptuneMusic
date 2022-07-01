import 'package:bloc/bloc.dart';
import 'package:neptune_music/controller/main_controller.dart';
import 'package:neptune_music/models/loading_enum.dart';
import 'package:neptune_music/repositories/get_artist_data.dart';
import 'package:neptune_music/models/artist_model.dart';
import 'package:neptune_music/models/song_model.dart';

part 'artist_profile_state.dart';

class ArtistProfileCubit extends Cubit<ArtistProfileState> {
  final repo = GetArtistsData();
  ArtistProfileCubit() : super(ArtistProfileState.initial());
  void getUser(String id) async {
    try {
      emit(state.copyWith(status: LoadPage.loading));
      emit(
        state.copyWith(
          songs: await repo.getSongs(id),
          artist: await repo.getArtistData(id),
          status: LoadPage.loaded,
        ),
      );
    } catch (e) {
      emit(state.copyWith(status: LoadPage.error));
    }
  }

  void playSongs(MainController controller, int initial) {
    controller.playSong(controller.convertToAudio(state.songs), initial);
  }
}
