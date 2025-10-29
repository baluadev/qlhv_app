import 'package:flutter/material.dart';
import 'package:qlhv_app/models/user_model.dart';

class StatsScreen extends StatelessWidget {
  final UserModel userModel;
  const StatsScreen({super.key, required this.userModel});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: userModel.thongke(),
      builder: (context, snapshot) {
        List<Widget> cards = [];
        int tongHV = 0;
        if (snapshot.data != null) {
          final data = snapshot.data as Map;
          tongHV = data["tongHV"] ?? 0;
          cards = [
            _ThongKeItem("Đang học", data["dangHoc"]),
            _ThongKeItem("LT chưa TH", data["ltChuaTH"]),
            _ThongKeItem("TH đã xong LT", data["thDaXongLT"]),
            _ThongKeItem("TH chưa xong LT", data["thChuaXongLT"]),
            _ThongKeItem("Chờ tốt nghiệp", data["choTotNghiep"]),
            _ThongKeItem("Chờ sát hạch", data["choSatHach"]),
            _ThongKeItem("Sắp hết hạn", data["sapHetHan"]),
            _ThongKeItem("Nợ học phí", data["noHocPhi"]),
          ];
        }
        return Scaffold(
          appBar: AppBar(
            title: const Text("Thống kê học viên"),
          ),
          body: Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                GestureDetector(
                  child: _TongHocVienCard(total: tongHV),
                  onTap: () {
                    Navigator.pushNamed(context, '/list');
                  },
                ),
                const SizedBox(height: 12),
                Expanded(
                  child: GridView.count(
                    crossAxisCount: 2,
                    mainAxisSpacing: 12,
                    crossAxisSpacing: 12,
                    childAspectRatio: 1.4,
                    children: cards,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class _TongHocVienCard extends StatelessWidget {
  final int total;

  const _TongHocVienCard({required this.total});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.blueAccent,
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.people, color: Colors.white, size: 36),
            const SizedBox(width: 16),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Tổng học viên",
                  style: TextStyle(color: Colors.white70, fontSize: 16),
                ),
                Text(
                  "$total",
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

class _ThongKeItem extends StatelessWidget {
  final String title;
  final int? count;

  const _ThongKeItem(this.title, this.count);

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "$count",
              style: const TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.bold,
                color: Colors.blueAccent,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              title,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 14,
                color: Colors.black87,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
