
import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:invincix_task_user_app/constants.dart';
import 'package:invincix_task_user_app/models/all_users_model.dart';
import 'package:invincix_task_user_app/models/single_user_model.dart';

class Repository{
   final Dio _dio = Dio();

   Future<AllUsers> allUsers(int page) async{
     try{
       final response = await _dio.get('$getUsers$page');
       return allUsersFromJson(json.encode(response.data));
     }catch(e){
       rethrow;
     }
   }

   Future<SingleUser> singleUser(int id)async{
     try{
       final response = await _dio.get('$getSingleUser$id');
       return singleUserFromJson(json.encode(response.data));
     }catch(e){
       rethrow;
     }
   }
}