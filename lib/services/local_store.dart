import 'dart:convert';

import 'package:qlhv_app/models/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocalStore {
  static final LocalStore inst = LocalStore._internal();
  LocalStore._internal();

  final String _user = 'user';
  final String _teacher = 'teacher';
  final String _cars = 'cars';

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

  List<String> getTeachers() {
    return prefs.getStringList(_teacher) ?? [];
  }

  Future<bool> addTeacher(String value) async {
    final currentList = getTeachers();
    if (currentList.contains(value)) {
      return true;
    }
    currentList.add(value);
    return await prefs.setStringList(_teacher, currentList);
  }

  Future<bool> removeTeacher(String value) async {
    final currentList = getTeachers();
    if (!currentList.contains(value)) {
      return true;
    }
    currentList.remove(value);
    return await prefs.setStringList(_teacher, currentList);
  }

  Future<bool> editTeacher(int index, String value) async {
    final currentList = getTeachers();
    if (index < 0 || index >= currentList.length) {
      return false;
    }
    currentList[index] = value;
    return await prefs.setStringList(_teacher, currentList);
  }

  List<String> getCars() {
    return prefs.getStringList(_cars) ?? [];
  }

  Future<bool> addCar(String value) async {
    final currentList = getCars();
    if (currentList.contains(value)) {
      return true;
    }
    currentList.add(value);
    return await prefs.setStringList(_cars, currentList);
  }

  Future<bool> removeCar(String value) async {
    final currentList = getCars();
    if (!currentList.contains(value)) {
      return true;
    }
    currentList.remove(value);
    return await prefs.setStringList(_cars, currentList);
  }

  Future<bool> editCar(int index, String value) async {
    final currentList = getCars();
    if (index < 0 || index >= currentList.length) {
      return false;
    }
    currentList[index] = value;
    return await prefs.setStringList(_cars, currentList);
  }

  Future<bool> clear() async {
    return await prefs.clear();
  }
}
