import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/home_bloc.dart';
import '../bloc/home_state.dart';
import '../../chat/presentation/chat_screen.dart';

class UsersTab extends StatelessWidget {
  const UsersTab({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(
      builder: (_, state) {
        return ListView.builder(
          key: const PageStorageKey('users'),
          itemCount: state.users.length,
          itemBuilder: (_, i) {
            final user = state.users[i];
            return ListTile(
              leading: CircleAvatar(child: Text(user.initial)),
              title: Text(user.name),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => ChatScreen(userIndex: i),
                  ),
                );
              },
            );
          },
        );
      },
    );
  }
}
