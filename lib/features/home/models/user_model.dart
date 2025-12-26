class UserModel {
  final String name;
  UserModel(this.name);

  String get initial => name[0].toUpperCase();
}
