import 'package:flutter/material.dart';
import 'package:qlhv_app/const.dart';
import 'package:qlhv_app/enums.dart';
import 'package:qlhv_app/helper/dialog_helper.dart';
import 'package:qlhv_app/models/profile_model.dart';
import 'package:qlhv_app/models/user_model.dart';
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
        actions: [
          IconButton(
              onPressed: () {
                Navigator.pushNamed(context, '/stats');
              },
              icon: const Icon(Icons.bar_chart))
        ],
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
                  final countLT = Utils.countCompleted([
                    item.online,
                    item.taptrung,
                    item.kiemtralythuyet,
                    item.kiemtramophong,
                    item.cabin
                  ]);

                  final statusLT = countLT < 5 ? Status.failed : Status.passed;

                  //
                  final totalHoursTH = Utils.getTotalHours(
                    hocVo: item.hocVo,
                    chayDAT: item.chayDAT,
                    saHinh: item.saHinh,
                  );

                  final totalKmsTH = Utils.getTotalKm(
                    hocVo: item.hocVo,
                    chayDAT: item.chayDAT,
                    saHinh: item.saHinh,
                  );

                  final completedTh = (totalHoursTH >= Const.maxHours &&
                          totalKmsTH >= Const.maxKms)
                      ? Status.passed
                      : Status.failed;

                  final totalHoursChip = (item.hocChip ?? [])
                      .fold<int>(0, (sum, item) => sum + (item.hour ?? 0));

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
                            '($countLT/5)',
                            color: statusLT == Status.passed
                                ? Colors.green
                                : Colors.red,
                          ),
                          info(
                            'Thực hành',
                            '($totalHoursTH giờ - $totalKmsTH km)',
                            color: completedTh == Status.passed
                                ? Colors.green
                                : Colors.red,
                          ),
                          info('Học Chip', '$totalHoursChip giờ'),
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
