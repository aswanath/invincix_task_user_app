import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:invincix_task_user_app/bloc/users_bloc.dart';
import 'package:invincix_task_user_app/screens/home_page.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => UsersBloc(),
      child: MaterialApp(
        title: 'User App',
        theme: ThemeData(
          appBarTheme: const AppBarTheme(backgroundColor: Colors.deepOrange),
          primarySwatch: Colors.deepOrange,
        ),
        home: HomePage(),
      ),
    );
  }
}