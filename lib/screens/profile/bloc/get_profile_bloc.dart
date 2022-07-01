import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:neptune_music/repositories/generate_user_id.dart';
import 'package:equatable/equatable.dart';
import 'package:neptune_music/models/user_model.dart';
import 'package:neptune_music/models/post_model.dart';
import 'package:neptune_music/repositories/get_current_user.dart';
import 'package:neptune_music/repositories/user_events_repo.dart';

part 'get_profile_event.dart';
part 'get_profile_state.dart';

class GetProfileBloc extends Bloc<GetProfileEvent, GetProfileState> {
  final repo = GetUserInfo();
  final followRepo = UserEvents();
  GetProfileBloc() : super(GetProfileInitial()) {
    on<GetProfileEvent>(
      (event, emit) async {
        if (event is GetUsesrPostsEvent) {
          try {
            emit(GetProfileLoading());
            genrateId(FirebaseAuth.instance.currentUser!.uid);
            final posts = await repo.getUserPosts(event.uid);
            final user = await repo.getUserInfo(event.uid);

            emit(GetProfileLoaded(user: user, posts: posts));
          } catch (e) {
            // print(e.toString());
            emit(GetProfileError());
          }
        }
      },
    );
  }
}
