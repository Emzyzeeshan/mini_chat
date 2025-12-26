import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/home_bloc.dart';
import '../bloc/home_state.dart';
import '../bloc/home_event.dart';
import 'users_tab.dart';
import 'chat_history_tab.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) {
        return Scaffold(
          body: CustomScrollView(
            slivers: [
              SliverAppBar(
                floating: true,
                snap: true,
                centerTitle: true,
                title: ToggleButtons(
                  isSelected: [
                    state.selectedTab == 0,
                    state.selectedTab == 1
                  ],
                  onPressed: (i) =>
                      context.read<HomeBloc>().add(SwitchTab(i)),
                  children: const [
                    Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16),
                        child: Text("Users")),
                    Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16),
                        child: Text("Chat History")),
                  ],
                ),
              ),
              SliverFillRemaining(
                child: IndexedStack(
                  index: state.selectedTab,
                  children: const [
                    UsersTab(),
                    ChatHistoryTab(),
                  ],
                ),
              ),
            ],
          ),
          floatingActionButton: state.selectedTab == 0
              ? FloatingActionButton(
            onPressed: () {
              context.read<HomeBloc>().add(AddUser("User ${state.users.length + 1}"));
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text("User added")),
              );
            },
            child: const Icon(Icons.add),
          )
              : null,
        );
      },
    );
  }
}
