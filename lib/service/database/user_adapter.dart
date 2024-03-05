import 'package:hive/hive.dart';

part 'user_adapter.g.dart';

@HiveType(typeId: 0)
class User extends HiveObject {
  @HiveField(0)
  String username;

  @HiveField(1)
  String password;

  @HiveField(2)
  bool isLogged;

  User(this.username, this.password, this.isLogged);
}
