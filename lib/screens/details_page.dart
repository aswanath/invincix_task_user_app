import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:invincix_task_user_app/bloc/users_bloc.dart';
import 'package:invincix_task_user_app/models/single_user_model.dart';

class DetailsPage extends StatelessWidget {
  const DetailsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<UsersBloc, UsersState>(builder: (context, state) {
        if (state is UserDetails) {
          return Stack(
            children: [
              Container(
                width: double.infinity,
                height: 320,
                decoration: const BoxDecoration(
                    gradient: LinearGradient(
                        colors: [Colors.deepOrange, Colors.orange])),
                child: Column(
                  children: [
                    const SizedBox(
                      height: 80,
                    ),
                    CircleAvatar(
                      radius: 60,
                      foregroundImage: NetworkImage(state.user.data.avatar),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      state.user.data.firstName + state.user.data.lastName,
                      style: const TextStyle(color: Colors.white, fontSize: 32),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(state.user.data.email),
                    const SizedBox(
                      height: 10,
                    ),
                    Text("id: ${state.user.data.id}")
                  ],
                ),
              ),
              Positioned(
                top: 30,
                  left: 10,
                  child: IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: const Icon(
                        Icons.arrow_back_rounded,
                        color: Colors.white,
                        size: 30,
                      ))),
            ],
          );
        } else if(state is UserDetailsFailed){
          return const Center(child: Text("Something went wrong, Please go back and come later"),);
        }else{
          return const Center(child: CircularProgressIndicator(),);
        }
      }),
    );
  }
}
