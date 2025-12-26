import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/home_bloc.dart';
import '../bloc/home_state.dart';

class ChatHistoryTab extends StatelessWidget {
  const ChatHistoryTab({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(
      builder: (_, state) {
        return ListView.builder(
          key: const PageStorageKey('history'),
          itemCount: state.history.length,
          itemBuilder: (_, i) {
            final h = state.history[i];
            return ListTile(
              leading: CircleAvatar(child: Text(h.user.initial)),
              title: Text(h.user.name),
              subtitle: Text(h.lastMessage),
              trailing: Text(
                "${h.time.hour}:${h.time.minute.toString().padLeft(2, '0')}",
              ),
            );
          },
        );
      },
    );
  }
}
