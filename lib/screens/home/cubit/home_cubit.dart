import 'package:bloc/bloc.dart';
import 'package:neptune_music/models/artist_model.dart';
import 'package:neptune_music/models/loading_enum.dart';
import 'package:neptune_music/models/song_model.dart';
import 'package:neptune_music/repositories/get_home_page.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  final repo = GetHomePage();
  HomeCubit() : super(HomeState.initial());

  void getUsers() async {
    try {
      emit(state.copyWith(status: LoadPage.loading));

      emit(state.copyWith(
        artists: await repo.getArtists(),
        songs: await repo.getSongs(),
        status: LoadPage.loaded,
      ));
    } catch (e) {
      emit(state.copyWith(status: LoadPage.error));
    }
  }
}
