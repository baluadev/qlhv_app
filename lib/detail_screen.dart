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
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final args = ModalRoute.of(context)!.settings.arguments;
      if (args is ProfileModel) {
        profile = args;
        ProfileModel()
            .getProfile(profile?.id ?? '')
            .then((value) => setState(() {
                  profile = value;
                }));
      }
    });
  }

  Color getStatusColor(int status) {
    switch (Status.values[status]) {
      case Status.passed:
        return Colors.green;
      case Status.failed:
        return Colors.red;
      case Status.none:
        return Colors.black;
      default:
        return Colors.black;
    }
  }

  int countCompleted(List<int?> list) {
    return list.where((element) => element == Status.passed.index).length;
  }

  int getTotalHours() {
    int hocVo = (profile?.hocVo ?? [])
        .fold<int>(0, (sum, item) => sum + (item.hour ?? 0));
    int chayDAT = (profile?.chayDAT ?? [])
        .fold<int>(0, (sum, item) => sum + (item.hour ?? 0));
    int saHinh = (profile?.saHinh ?? [])
        .fold<int>(0, (sum, item) => sum + (item.hour ?? 0));
    int hocChip = (profile?.hocChip ?? [])
        .fold<int>(0, (sum, item) => sum + (item.hour ?? 0));
    return hocVo + chayDAT + saHinh + hocChip;
  }

  int getTotalKm() {
    int hocVo = (profile?.hocVo ?? [])
        .fold<int>(0, (sum, item) => sum + (item.km ?? 0));
    int chayDAT = (profile?.chayDAT ?? [])
        .fold<int>(0, (sum, item) => sum + (item.km ?? 0));
    int saHinh = (profile?.saHinh ?? [])
        .fold<int>(0, (sum, item) => sum + (item.km ?? 0));
    int hocChip = (profile?.hocChip ?? [])
        .fold<int>(0, (sum, item) => sum + (item.km ?? 0));
    return hocVo + chayDAT + saHinh + hocChip;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          '${profile?.hovaten ?? ''} - ${profile?.lophoc ?? ''}',
          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
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
            ExpansionTile(
              title: const Text(
                '1. Thông tin cá nhân',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
              expandedAlignment: Alignment.centerLeft,
              expandedCrossAxisAlignment: CrossAxisAlignment.start,
              childrenPadding: const EdgeInsets.only(left: 20),
              iconColor: Colors.green,
              children: [
                info('Họ và tên', profile?.hovaten),
                info('Ngày sinh', profile?.ngaysinh),
                info('CCCD', profile?.cccd),
                info('SĐT', profile?.sdt),
                info('Địa chỉ', profile?.diachi),
              ],
            ),
            ExpansionTile(
              title: const Text(
                '2. Thông tin lớp học',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
              expandedAlignment: Alignment.centerLeft,
              expandedCrossAxisAlignment: CrossAxisAlignment.start,
              childrenPadding: const EdgeInsets.only(left: 20),
              iconColor: Colors.green,
              children: [
                info('Lớp học', profile?.lophoc),
                info('Ngày khai giảng', profile?.ngaykhaigiang),
                info('Nguồn học viên', profile?.nguonHV),
                info('Giáo viên dạy DAT', profile?.giaovienDAT),
                info('Xe DAT', profile?.xeDAT),
                info('Gói học phí', profile?.loaiHocPhi),
              ],
            ),
            ExpansionTile(
              title: Text(
                '3. Lộ trình lý thuyết (${countCompleted([
                      profile?.online,
                      profile?.taptrung,
                      profile?.kiemtralythuyet,
                      profile?.kiemtramophong,
                      profile?.cabin
                    ])}/5)',
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
              expandedAlignment: Alignment.centerLeft,
              expandedCrossAxisAlignment: CrossAxisAlignment.start,
              childrenPadding: const EdgeInsets.only(left: 20),
              iconColor: Colors.green,
              children: [
                info(
                  'Học online: ',
                  Status.values[profile?.online ?? 2].text,
                  color: getStatusColor(
                    profile?.online ?? 2,
                  ),
                ),
                info(
                  'Học tập trung',
                  Status.values[profile?.taptrung ?? 2].text,
                  color: getStatusColor(
                    profile?.taptrung ?? 2,
                  ),
                ),
                info(
                  'Kiểm tra lý thuyết: ',
                  Status.values[profile?.kiemtralythuyet ?? 2].text,
                  color: getStatusColor(
                    profile?.kiemtralythuyet ?? 2,
                  ),
                ),
                info(
                  'Kiểm tra mô phỏng',
                  Status.values[profile?.kiemtramophong ?? 2].text,
                  color: getStatusColor(
                    profile?.kiemtramophong ?? 2,
                  ),
                ),
                info(
                  'Học cabin',
                  Status.values[profile?.cabin ?? 0].text,
                  color: getStatusColor(
                    profile?.cabin ?? 2,
                  ),
                ),
              ],
            ),
            ExpansionTile(
              title: Text(
                '4. Lộ trình học thực hành (${getTotalHours()} giờ - ${getTotalKm()} km)',
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
              expandedAlignment: Alignment.centerLeft,
              expandedCrossAxisAlignment: CrossAxisAlignment.start,
              childrenPadding: const EdgeInsets.only(left: 20),
              iconColor: Colors.green,
              children: [
                HocVoTable(
                  title: 'Học vỡ',
                  hocVoData: profile?.hocVo ?? [],
                ),
                const SizedBox(height: 8),
                HocVoTable(
                  title: 'Chạy DAT',
                  hocVoData: profile?.chayDAT ?? [],
                ),
                const SizedBox(height: 8),
                HocVoTable(
                  title: 'Học sa hình',
                  hocVoData: profile?.saHinh ?? [],
                ),
                const SizedBox(height: 8),
                HocVoTable(
                  title: 'Học Chip',
                  hocVoData: profile?.hocChip ?? [],
                ),
                const SizedBox(height: 8),
              ],
            ),
            ExpansionTile(
              title: const Text(
                '5. Thông tin bổ sung',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
              expandedAlignment: Alignment.centerLeft,
              expandedCrossAxisAlignment: CrossAxisAlignment.start,
              childrenPadding: const EdgeInsets.only(left: 20),
              iconColor: Colors.green,
              children: [],
            ),
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

class HocVoTable extends StatelessWidget {
  final String title;
  final List<RowTime> hocVoData;

  const HocVoTable({super.key, required this.hocVoData, required this.title});

  int totalHours() {
    return hocVoData.fold<int>(0, (sum, item) => sum + (item.hour ?? 0));
  }

  int totalKm() {
    return hocVoData.fold<int>(0, (sum, item) => sum + (item.km ?? 0));
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal, // nếu bảng rộng
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 8),
          DataTable(
              dataRowMaxHeight: 30,
              dataRowMinHeight: 30,
              headingRowHeight: 30,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
              ),
              border: TableBorder(
                horizontalInside: BorderSide(color: Colors.grey.shade300),
                verticalInside: BorderSide(color: Colors.grey.shade300),
              ),
              columns: const [
                DataColumn(label: Text("Ngày học")),
                DataColumn(label: Text("Số giờ")),
                DataColumn(label: Text("Số km")),
              ],
              rows: [
                ...hocVoData.map(
                  (row) => DataRow(cells: [
                    DataCell(Center(child: Text('${row.date}'))),
                    DataCell(Center(child: Text('${row.hour}'))),
                    DataCell(Center(child: Text('${row.km}'))),
                  ]),
                ),
                DataRow(cells: [
                  const DataCell(Center(child: Text('Tổng'))),
                  DataCell(Center(child: Text('${totalHours()} giờ'))),
                  DataCell(Center(child: Text('${totalKm()} km'))),
                ]),
              ]),
        ],
      ),
    );
  }
}
