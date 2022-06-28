import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:invincix_task_user_app/bloc/users_bloc.dart';
import 'package:invincix_task_user_app/models/all_users_model.dart';
import 'package:invincix_task_user_app/screens/details_page.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final ScrollController scrollController = ScrollController();
  List<Datum> usersList = [];
  bool isFinished = false;

  @override
  initState() {
    super.initState();
    context.read<UsersBloc>().add(LoadUsersEvent(page: 1));
    scrollController.addListener(() {
      if (scrollController.position.pixels ==
          scrollController.position.maxScrollExtent) {
        if (!isFinished) {
          context.read<UsersBloc>().add(LoadUsersEvent(page: 2));
          isFinished = true;
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<UsersBloc, UsersState>(
      listener: (context, state) {
        if (state is NavigateToDetails) {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => BlocProvider.value(
                        value: context.read<UsersBloc>(),
                        child: DetailsPage(),
                      )));
          return;
        }
        if(state is AllUsersFailed){
          const ScaffoldMessenger(child: SnackBar(content: Text("Something Went Wrong, Please restart app")));
        }
      },
      child: Scaffold(
        appBar: AppBar(
          systemOverlayStyle: const SystemUiOverlayStyle(statusBarColor: Colors.deepOrange),
          title: const Text(
            "Users",
            style: TextStyle(color: Colors.white),
          ),
          centerTitle: true,
        ),
        body: SizedBox(
          height: 300,
          child: BlocBuilder<UsersBloc, UsersState>(buildWhen: (prev, curr) {
            if (curr is UsersLoaded) {
              return true;
            }
            return false;
          }, builder: (context, state) {
            if (state is UsersLoaded) {
              usersList.addAll(state.users.data);
              return ListView.builder(
                  controller: scrollController,
                  itemCount: usersList.length,
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () {
                        context
                            .read<UsersBloc>()
                            .add(GetSingleUserEvent(id: index+1));
                      },
                      child: ListTile(
                        leading: CircleAvatar(
                          radius: 40,
                          foregroundImage:
                              NetworkImage(usersList[index].avatar),
                        ),
                        title: Text(
                          '${usersList[index].firstName} ${usersList[index].lastName}',
                          style: const TextStyle(fontSize: 22),
                        ),
                        subtitle: Text(
                          usersList[index].email,
                          style: const TextStyle(fontSize: 18),
                        ),
                      ),
                    );
                  });
            } else {
              return const Center(child: CircularProgressIndicator());
            }
          }),
        ),
      ),
    );
  }
}
