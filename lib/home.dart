
import 'package:flutter/material.dart';
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

    list.clear();

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

                  //phân biệt màu nguồn học viên

                  return GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, '/detail', arguments: item);
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Họ và tên: ${item.hovaten}'),
                          Text('SDT: ${item.sdt}'),
                          Text('Khóa: ${item.lophoc}'),
                          Text('Lý thuyết: passed(3/5)'),
                          // Text('1. online (passed), '),
                          // Text('2. tập trung (passed), '),
                          // Text('3. kiem tra lý thuyết (failed), '),
                          Text('Thực hành: (50h - 30km)'), // hiện thị tổng số giờ vs km của tất cả enum ThucHanh
                          // Text('1. Học Vỡ (3h), '), //thêm nhiều dòng
                          // Text(
                          //     '2. Chạy DAT (số km + số giờ), '), //thêm nhiều dòng (ngày+ giờ + km)
                          // Text(
                          //     '3. Học sa hình ( số giờ), '), //thêm nhiều dòng (ngày + giờ)
                          // Text('4. Thi tốt nghiệp ( passed), '),
                          // Text(
                          //     '5. Học Chip ( giờ), '), //thêm nhiều dòng (ngày + giờ )
                        ],
                      ),
                    ),
                  );
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
