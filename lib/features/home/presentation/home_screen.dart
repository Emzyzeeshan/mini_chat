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
                title: _topSwitcher(context, state.selectedTab),

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
            backgroundColor: Colors.blue,
            child: const Icon(Icons.add, size: 28),
            onPressed: () {
              context.read<HomeBloc>()
                  .add(AddUser("User ${state.users.length + 1}"));
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text("User added"),
                  behavior: SnackBarBehavior.floating,
                ),
              );
            },
          )
          : null,
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: 0,
            selectedItemColor: Colors.blue,
            unselectedItemColor: Colors.grey,
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.chat_bubble_outline),
                label: "Home",
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.local_offer_outlined),
                label: "Offers",
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.settings_outlined),
                label: "Settings",
              ),
            ],
          ),

        );
      },
    );
  }
}


Widget _topSwitcher(BuildContext context, int selected) {
  return Container(
    padding: const EdgeInsets.all(4),
    decoration: BoxDecoration(
      color: Colors.grey.shade200,
      borderRadius: BorderRadius.circular(24),
    ),
    child: Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        _switchItem(context, "Users", 0, selected),
        _switchItem(context, "Chat History", 1, selected),
      ],
    ),
  );
}

Widget _switchItem(
    BuildContext context, String title, int index, int selected) {
  final isActive = index == selected;
  return GestureDetector(
    onTap: () =>
        context.read<HomeBloc>().add(SwitchTab(index)),
    child: Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: isActive ? Colors.white : Colors.transparent,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        title,
        style: TextStyle(
          fontWeight: FontWeight.w600,
          color: isActive ? Colors.blue : Colors.grey,
        ),
      ),
    ),
  );
}
