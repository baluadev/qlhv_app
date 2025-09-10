import 'package:flutter/material.dart';
import 'package:qlhv_app/helper/dialog_helper.dart';
import 'package:qlhv_app/models/user_model.dart';

class LoginScreen extends StatefulWidget {
  final UserModel userModel;
  const LoginScreen({super.key, required this.userModel});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late UserModel userModel;
  final userController = TextEditingController();
  final passController = TextEditingController();

  @override
  void initState() {
    userModel = widget.userModel;
    super.initState();
  }

  @override
  void dispose() {
    userController.dispose();
    passController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final enabledBorder = OutlineInputBorder();
    final focusedBorder = OutlineInputBorder();
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            children: [
              TextField(
                controller: userController,
                decoration: InputDecoration(
                  enabledBorder: enabledBorder,
                  focusedBorder: focusedBorder,
                  prefixIcon: const Icon(
                    Icons.person,
                    color: Colors.black,
                  ),
                  hintText: 'Nhập tài khoản',
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: passController,
                decoration: InputDecoration(
                  enabledBorder: enabledBorder,
                  focusedBorder: focusedBorder,
                  prefixIcon: const Icon(
                    Icons.lock,
                    color: Colors.black,
                  ),
                  hintText: 'Nhập mật khẩu',
                ),
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () async {
                  DialogHelper.showLoading();

                  final username = userController.text;
                  final password = passController.text;
                  if (username.isEmpty || password.isEmpty) {
                    DialogHelper.hideLoading();
                    DialogHelper.showToast(
                        'Username hoặc mật khẩu không được để trống!');
                    return;
                  }
                  final success = await userModel.login(username, password);
                  await DialogHelper.hideLoading();
                  if (success) {
                    // ignore: use_build_context_synchronously
                    Navigator.pushReplacementNamed(context, '/home');
                  }
                },
                child: const Text(
                  'Đăng nhập',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
