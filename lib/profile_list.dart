import 'package:flutter/material.dart';
import 'package:qlhv_app/const.dart';
import 'package:qlhv_app/enums.dart';

import 'models/profile_model.dart';
import 'utils.dart';

class ProfileListScreen extends StatelessWidget {
  const ProfileListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Danh sách học viên'),
      ),
      body: FutureBuilder(
        future: ProfileModel().listProfile(),
        builder: (context, snapshot) {
          List<ProfileModel> list = [];
          if (snapshot.data != null) {
            list = snapshot.data ?? [];
          }


          return ListView.builder(
            itemCount: list.length,
            padding: const EdgeInsets.all(16),
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

              final completedTh =
                  (totalHoursTH >= Const.maxHours && totalKmsTH >= Const.maxKms)
                      ? Status.passed
                      : Status.failed;

              final totalHoursChip = (item.hocChip ?? [])
                  .fold<int>(0, (sum, item) => sum + (item.hour ?? 0));

              return GestureDetector(
                onTap: () async {
                  await Navigator.pushNamed(context, '/detail',
                      arguments: item);
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
          );
        },
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
