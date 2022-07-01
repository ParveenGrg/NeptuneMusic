import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:neptune_music/repositories/generate_user_id.dart';
import 'package:neptune_music/repositories/get_current_user.dart';
import 'package:neptune_music/repositories/get_notification.dart';
import 'package:neptune_music/models/user_model.dart';
// import 'package:social_media/logger.dart';

part 'current_user_state.dart';

class CurrentUserCubit extends Cubit<CurrentUserState> {
  CurrentUserCubit() : super(CurrentUserState.initial());

  void setCurrentUser(String uid) async {
    final repo = GetUserInfo();

    try {
      emit(state.copyWith(status: CurrentUserStatus.loading));
      final user = await repo.getUserInfo(uid);
      final nrepo = GetNotifications();
      final result = await nrepo
          .getNotifications(genrateId(FirebaseAuth.instance.currentUser!.uid));

      if (result.isNotEmpty) {
        emit(state.copyWith(
            status: CurrentUserStatus.loaded, user: user, isNote: true));
      }
      // logger.d(user.toJson());
      emit(state.copyWith(status: CurrentUserStatus.loaded, user: user));
    } catch (e) {
      emit(state.copyWith(status: CurrentUserStatus.error));
    }
  }

  void changeIcon() => emit(state.copyWith(isNote: false));
}
