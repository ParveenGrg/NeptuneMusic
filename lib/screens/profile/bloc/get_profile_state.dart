part of 'get_profile_bloc.dart';

enum EventStatus {
  loading,
  loaded,
  error,
}

abstract class GetProfileState extends Equatable {
  const GetProfileState();

  @override
  List<Object> get props => [];
}

class GetProfileInitial extends GetProfileState {}

class GetProfileLoading extends GetProfileState {}

class GetProfileLoaded extends GetProfileState {
  final UserModel user;
  final List<PostModel> posts;
  const GetProfileLoaded({
    required this.user,
    required this.posts,
  });
}

class GetProfileError extends GetProfileState {}
