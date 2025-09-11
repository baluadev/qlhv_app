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
    Navigator.pushNamed(context, '/add');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        surfaceTintColor: Colors.transparent,
        title: const Text(
          'Tìm kiếm',
          style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
        ),
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
                enabledBorder: const OutlineInputBorder(),
                focusedBorder: const OutlineInputBorder(),
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
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16),
              child: ElevatedButton(
                onPressed: onSearchChanged,
                child: const Text(
                  'Tìm kiếm',
                  style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Colors.black),
                ),
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: list.length,
                itemBuilder: (context, index) {
                  final item = list[index];
                  return ListTile(
                    shape: const OutlineInputBorder(),
                    onTap: () {
                      Navigator.pushNamed(context, '/detail', arguments: item);
                    },
                    title: Text('Họ và tên: ${item.hovaten}'),
                    subtitle: Text('SDT: ${item.sdt}'),
                    trailing: const Icon(Icons.arrow_forward),
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
