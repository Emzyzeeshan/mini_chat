abstract class HomeEvent {}

class SwitchTab extends HomeEvent {
  final int index;
  SwitchTab(this.index);
}

class AddUser extends HomeEvent {
  final String name;
  AddUser(this.name);
}

class UpdateChatHistory extends HomeEvent {
  final int userIndex;
  final String message;
  UpdateChatHistory(this.userIndex, this.message);
}
