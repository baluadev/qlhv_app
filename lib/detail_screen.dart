import 'package:flutter/material.dart';
import 'package:qlhv_app/enums.dart';
import 'package:qlhv_app/models/profile_model.dart';

class DetailScreen extends StatefulWidget {
  const DetailScreen({super.key});

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  ProfileModel? profile;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final args = ModalRoute.of(context)!.settings.arguments;
    if (args is ProfileModel) {
      profile = args;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:  Text(
          '${profile?.hovaten ?? ''} - ${profile?.lophoc ?? ''}',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pushNamed(context, '/add', arguments: profile);
            },
            icon: const Icon(
              Icons.edit,
              color: Colors.black,
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              '1. Thông tin cá nhân',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 4),
            Padding(
              padding: const EdgeInsets.only(left: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  info('Họ và tên', profile?.hovaten),
                  info('Ngày sinh', profile?.ngaysinh),
                  info('CCCD', profile?.cccd),
                  info('SĐT', profile?.sdt),
                  info('Địa chỉ', profile?.diachi),
                ],
              ),
            ),
            const Text(
              '2. Thông tin lớp học',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 4),
            Padding(
              padding: const EdgeInsets.only(left: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  info('Lớp học', profile?.lophoc),
                  info('Ngày khai giảng', profile?.ngaykhaigiang),
                  // info('Nguồn học viên',
                  //     NguonHV.values[profile?.nguonHV ?? 0].text),
                  // info('Giáo viên dạy DAT',
                  //     GiaoVienDAT.values[profile?.giaovienDAT ?? 0].text),
                  // info('Xe DAT', XeDAT.values[profile?.xeDAT ?? 0].text),
                  // info('Gói học phí',
                  //     LoaiHocPhi.values[profile?.loaiHocPhi ?? 0].text),
                ],
              ),
            ),
            const Text(
              '3. Lộ trình lý thuyết',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 4),
            Padding(
              padding: const EdgeInsets.only(left: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // info('Ngày tập trung', profile?.ngaytaptrung),
                  // info('Ngày học kiểm tra lý thuyết',
                  //     profile?.ngayhockiemtralythuyet),
                  // info('Ngày học cabin', profile?.ngayhoccabin),
                ],
              ),
            ),
            const Text(
              '4. Lộ trình học thực hành',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 4),
            Padding(
              padding: const EdgeInsets.only(left: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // info('Học vỡ', profile?.ngayhocvo),
                  // Text('ngày: assss - giờ: 3h'), //thêm nhiều dòng
                  // info('Ngày học sa hình', profile?.ngayhocsahinh),
                  // info('Ngày học bổ túc thêm', profile?.ngayhobotucthem),
                ],
              ),
            ),
            const Text(
              '5. Thông tin bổ sung',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 4),
            Padding(
              padding: const EdgeInsets.only(left: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  info('Ưu đãi 1', ''),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget info(title, String? value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: RichText(
        text: TextSpan(
          text: '$title: ',
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: Colors.black,
          ),
          children: [
            TextSpan(
              text: value ?? '---',
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w400,
                color: Colors.black,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
