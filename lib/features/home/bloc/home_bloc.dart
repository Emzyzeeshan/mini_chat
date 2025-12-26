import 'package:flutter_bloc/flutter_bloc.dart';
import 'home_event.dart';
import 'home_state.dart';
import '../models/user_model.dart';
import '../models/chat_history_model.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc()
      : super(HomeState(
    selectedTab: 0,
    users: [],
    history: [],
  )) {
    on<SwitchTab>((e, emit) {
      emit(state.copyWith(selectedTab: e.index));
    });

    on<AddUser>((e, emit) {
      final user = UserModel(e.name);
      emit(state.copyWith(users: [...state.users, user]));
    });

    on<UpdateChatHistory>((e, emit) {
      final user = state.users[e.userIndex];
      final history = List<ChatHistoryModel>.from(state.history);
      history.removeWhere((h) => h.user.name == user.name);
      history.insert(
        0,
        ChatHistoryModel(
          user: user,
          lastMessage: e.message,
          time: DateTime.now(),
        ),
      );
      emit(state.copyWith(history: history));
    });
  }
}
