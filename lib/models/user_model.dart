import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:qlhv_app/const.dart';
import 'package:qlhv_app/helper/dialog_helper.dart';
import 'package:qlhv_app/services/local_store.dart';

class UserModel extends ChangeNotifier {
  final String? id;
  final String? username;
  final String? password;

  UserModel({
    this.id,
    this.username,
    this.password,
  });

  factory UserModel.fromJson(Map data) {
    return UserModel(
      id: data['id'],
      username: data['username'],
      password: data['password'],
    );
  }

  Map toJson() {
    return {
      'id': id,
      'username': username,
      'password': password,
    };
  }

  @override
  String toString() {
    return jsonEncode(toJson());
  }

  Future<bool> login(username, password) async {
    //test
    await Future.delayed(Duration(seconds: 2));
    await LocalStore.inst.addUser(
        UserModel(id: '1', username: 'nnn', password: 'ssss').toString());
    return true;

    var url = Uri.https(Const.baseUrl, 'login');
    final resp = await http.post(url, body: {
      'username': username,
      'password': password,
    });

    final data = json.decode(resp.body);
    if (resp.statusCode != 200) {
      final message = data['message'];
      DialogHelper.showToast(message);
      return false;
    }
    final id = data['user']['id'];
    final user = UserModel(
      id: id,
      username: username,
      password: password,
    );
    return await LocalStore.inst.addUser(user.toString());
  }
}
