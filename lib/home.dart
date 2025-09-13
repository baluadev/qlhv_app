import 'package:flutter/material.dart';
import 'package:qlhv_app/helper/dialog_helper.dart';
import 'package:qlhv_app/models/profile_model.dart';
import 'package:qlhv_app/utils.dart';

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
                    onTap: () async {
                      await Navigator.pushNamed(context, '/detail',
                          arguments: item);
                      onSearchChanged();
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      padding: const EdgeInsets.all(8),
                      margin: const EdgeInsets.only(bottom: 8),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          info('Họ và tên', item.hovaten),
                          info('SDT', item.sdt),
                          info('Khóa', item.lophoc),
                          info(
                            'Lý thuyết',
                            '(${Utils.countCompleted([
                                  item.online,
                                  item.taptrung,
                                  item.kiemtralythuyet,
                                  item.kiemtramophong,
                                  item.cabin
                                ])}/5)',
                            color: Colors.green,
                          ),
                          info(
                            'Thực hành',
                            '(${Utils.getTotalHours(
                              hocVo: item.hocVo,
                              chayDAT: item.chayDAT,
                              saHinh: item.saHinh,
                              hocChip: item.hocChip,
                            )} giờ - ${Utils.getTotalKm(
                              hocVo: item.hocVo,
                              chayDAT: item.chayDAT,
                              saHinh: item.saHinh,
                              hocChip: item.hocChip,
                            )} km)',
                            color: Colors.green,
                          ), // hiện thị tổng số giờ vs km của tất cả enum ThucHanh
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
                },
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget info(title, String? value, {Color color = Colors.black}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: RichText(
        text: TextSpan(
          text: '$title: ',
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w400,
            color: Colors.black,
          ),
          children: [
            TextSpan(
              text: value ?? '---',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: color,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
