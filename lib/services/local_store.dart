import 'dart:convert';

import 'package:qlhv_app/models/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocalStore {
  static final LocalStore inst = LocalStore._internal();
  LocalStore._internal();

  final String _user = 'user';

  late SharedPreferences prefs;
  Future<void> init() async {
    prefs = await SharedPreferences.getInstance();
  }

  Future<bool> addUser(String data) async {
    return await prefs.setString(_user, data);
  }

  UserModel? getUser() {
    final dataUser = prefs.getString(_user);

    if (dataUser == null) return null;

    final user = UserModel.fromJson(
      jsonDecode(dataUser),
    );

    return user;
  }
}
