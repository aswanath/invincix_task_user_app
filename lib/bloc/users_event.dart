part of 'users_bloc.dart';

@immutable
abstract class UsersEvent {}

class LoadUsersEvent extends UsersEvent{
  final int page;
  LoadUsersEvent({required this.page});
}

class GetSingleUserEvent extends UsersEvent{
  final int id;
  GetSingleUserEvent({required this.id});
}
