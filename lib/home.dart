import 'dart:async';

import 'package:flutter/material.dart';
import 'package:qlhv_app/models/profile_model.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Timer? _debounce;
  void onSearchChanged(String query) {
    if (_debounce?.isActive ?? false) {
      _debounce?.cancel();
      _debounce = Timer(const Duration(milliseconds: 500), () {
        //fetch
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            TextField(
              onChanged: onSearchChanged,
              decoration: const InputDecoration(
                hintText: 'Nhập từ khóa',
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {},
              child: const Text('Tìm kiếm'),
            ),
            Expanded(child: ListView.builder(
              itemBuilder: (context, index) {
                return ListTile(
                  onTap: () {
                    Navigator.pushNamed(context, '/detail',
                        arguments: ProfileModel(hovaten: 'ho va ten'));
                  },
                  title: Text('list 1'),
                );
              },
            ))
          ],
        ),
      ),
    );
  }
}
