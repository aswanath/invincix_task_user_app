
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:invincix_task_user_app/models/all_users_model.dart';
import 'package:invincix_task_user_app/models/single_user_model.dart';
import 'package:invincix_task_user_app/services/services.dart';
import 'package:meta/meta.dart';

part 'users_event.dart';
part 'users_state.dart';

class UsersBloc extends Bloc<UsersEvent, UsersState> {
  final Repository repository = Repository();
  UsersBloc() : super(UsersInitial()) {


    on<LoadUsersEvent>((event, emit) async{
      try {
        final users = await repository.allUsers(event.page);
        await Future.delayed(Duration(milliseconds: 500));
        emit(UsersLoaded(users: users));
      }catch(e){
         emit(AllUsersFailed());
      }
    });

    on<GetSingleUserEvent>((event, emit) async{
      emit(NavigateToDetails());
      try {
        final user = await repository.singleUser(event.id);
        emit(UserDetails(user: user));
      }catch(e){
        emit(UserDetailsFailed());
      }
    });
  }
}
