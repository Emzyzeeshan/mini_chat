import '../models/user_model.dart';
import '../models/chat_history_model.dart';

class HomeState {
  final int selectedTab;
  final List<UserModel> users;
  final List<ChatHistoryModel> history;

  HomeState({
    required this.selectedTab,
    required this.users,
    required this.history,
  });

  HomeState copyWith({
    int? selectedTab,
    List<UserModel>? users,
    List<ChatHistoryModel>? history,
  }) {
    return HomeState(
      selectedTab: selectedTab ?? this.selectedTab,
      users: users ?? this.users,
      history: history ?? this.history,
    );
  }
}
