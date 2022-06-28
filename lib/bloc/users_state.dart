part of 'users_bloc.dart';

@immutable
abstract class UsersState {}

class UsersInitial extends UsersState {}

class UsersLoaded extends UsersState{
  final AllUsers users;
  UsersLoaded({required this.users});
}

class AllUsersFailed extends UsersState{}

class NavigateToDetails extends UsersState{}

class UserDetails extends UsersState{
  final SingleUser user;
  UserDetails({required this.user});
}

class UserDetailsFailed extends UsersState{}