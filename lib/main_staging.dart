import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:onusworks_albums_app/app/app.dart';
import 'package:onusworks_albums_app/bootstrap.dart';
import 'package:onusworks_albums_app/service/database/user_adapter.dart';
import 'package:path_provider/path_provider.dart' as path_provider;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final appDocumentDir = await path_provider.getApplicationDocumentsDirectory();
  Hive.init(appDocumentDir.path);
  Hive.registerAdapter(
      UserAdapter()); // Register the adapter for the User class
  bootstrap(() => App());
}
