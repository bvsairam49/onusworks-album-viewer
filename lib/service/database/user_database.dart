import 'package:hive/hive.dart';
import 'package:onusworks_albums_app/service/database/user_adapter.dart';

class UserDatabase {
  final String userBoxName = 'userBox';
  static UserDatabase? _instance;

  UserDatabase._internal();

  factory UserDatabase() {
    _instance ??= UserDatabase._internal();
    return _instance!;
  }

  Future<void> openBox() async {
    await Hive.openBox(userBoxName);
  }

  Future<bool> isUsernameTaken(String username) async {
    var box = await Hive.openBox<User>(userBoxName);
    var users = box.values.toList();
    return users.any((user) => user.username == username);
  }

  Future<void> storeUserCredentials(String username, String password) async {
    var box = await Hive.openBox<User>(userBoxName);
    if (await isUsernameTaken(username)) {
      throw Exception('Username already exists');
    }
    var user = User(username, password, false);
    await box.put(username, user);
  }

  Future<bool> checkUserCredentials(String username, String password) async {
    var box = await Hive.openBox<User>(userBoxName);
    var user = box.get(username);
    return user != null &&
        user.username == username &&
        user.password == password;
  }

  Future<void> setLoggedIn(String username, bool isLoggedIn) async {
    var box = await Hive.openBox<User>(userBoxName);
    var user = box.get(username);
    user?.isLogged = isLoggedIn;
    await box.put(username, user!);
  }

  Future<void> setUsersLogout() async {
    //set users as logged out
    var box = await Hive.openBox<User>(userBoxName);
    var users = box.values.toList();
    var loggedInUsers = users.where((user) => user.isLogged);
    for (var user in loggedInUsers) {
      user.isLogged = false;
      box.put(user.username, user);
    }
  }

  Future<bool> isLoggedIn() async {
    var box = await Hive.openBox<User>(userBoxName);
    var users = box.values.toList();
    return users.any((user) => user.isLogged);
  }

  Future<bool> isUserCompletedOnboarding() async {
    var box = await Hive.openBox<User>(userBoxName);
    var users = box.values.toList();
    return users.isNotEmpty;
  }
}
