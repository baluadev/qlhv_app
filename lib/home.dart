import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:qlhv_app/helper/dialog_helper.dart';
import 'package:qlhv_app/models/profile_model.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<ProfileModel> list = [];
  final ProfileModel _profileModel = ProfileModel();
  final searchController = TextEditingController();
  void onSearchChanged() async {
    final query = searchController.text;

    if (query.isEmpty) {
      setState(() {
        list = [];
      });
      return;
    }

    DialogHelper.showLoading();
    list = await _profileModel.search(query);
    DialogHelper.hideLoading();
    setState(() {});
  }

  void addProfile() {
    Navigator.pushNamed(context, '/detail');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: addProfile,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            TextField(
              controller: searchController,
              onChanged: (value) {
                setState(() {});
              },
              decoration: InputDecoration(
                hintText: 'Nhập từ khóa',
                suffixIcon: searchController.text.isNotEmpty
                    ? IconButton(
                        icon: const Icon(Icons.close),
                        onPressed: () {
                          searchController.clear();
                          onSearchChanged();
                        },
                      )
                    : null,
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: onSearchChanged,
              child: const Text('Tìm kiếm'),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: list.length,
                itemBuilder: (context, index) {
                  final item = list[index];
                  return ListTile(
                    onTap: () {
                      Navigator.pushNamed(context, '/detail', arguments: item);
                    },
                    title: Text(item.hovaten ?? ''),
                    subtitle: Text(item.sdt ?? ''),
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
