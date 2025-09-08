import 'package:flutter/material.dart';

class DetailScreen extends StatefulWidget {
  const DetailScreen({super.key});

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  List<TextEditingController> controllers =
      List.generate(14, (index) => TextEditingController());

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    controllers.map((e) => e.dispose());
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final enabledBorder = OutlineInputBorder();
    final focusedBorder = OutlineInputBorder();
    const styleTitle = TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.bold,
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text("Thông tin chi tiết"),
      ),
      body: ListView(
        children: [
          ExpansionTile(
            title: const Text(
              '1. Thông tin cá nhân',
              style: styleTitle,
            ),
            onExpansionChanged: (expanded) {},
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                child: TextField(
                  controller: controllers[0],
                  decoration: InputDecoration(
                    enabledBorder: enabledBorder,
                    focusedBorder: focusedBorder,
                    hintText: 'Nhập họ và tên',
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                child: TextField(
                  controller: controllers[1],
                  readOnly: true,
                  decoration: InputDecoration(
                    enabledBorder: enabledBorder,
                    focusedBorder: focusedBorder,
                    hintText: 'Nhập ngày sinh',
                  ),
                  onTap: () async {
                    DateTime? picked = await showDatePicker(
                      context: context,
                      initialDate: DateTime(2000),
                      firstDate: DateTime(1900),
                      lastDate: DateTime.now(),
                      locale: const Locale("vi", "VN"),
                    );
                    if (picked != null) {
                      controllers[1].text =
                          "${picked.day}/${picked.month}/${picked.year}";
                    }
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                child: TextField(
                  controller: controllers[2],
                  keyboardType: TextInputType.number,
                  maxLength: 12,
                  decoration: InputDecoration(
                    enabledBorder: enabledBorder,
                    focusedBorder: focusedBorder,
                    counterText: '',
                    hintText: 'Nhập CCCD',
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                child: TextField(
                  controller: controllers[3],
                  keyboardType: TextInputType.phone,
                  decoration: InputDecoration(
                    enabledBorder: enabledBorder,
                    focusedBorder: focusedBorder,
                    hintText: 'Nhập SDT',
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                child: TextField(
                  controller: controllers[4],
                  decoration: InputDecoration(
                    enabledBorder: enabledBorder,
                    focusedBorder: focusedBorder,
                    hintText: 'Nhập địa chỉ',
                  ),
                ),
              ),
            ],
          ),
          ExpansionTile(
            title: const Text(
              '2. Thông tin lớp học',
              style: styleTitle,
            ),
            onExpansionChanged: (expanded) {},
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                child: TextField(
                  controller: controllers[5],
                  decoration: InputDecoration(
                    enabledBorder: enabledBorder,
                    focusedBorder: focusedBorder,
                    hintText: 'Nhập lớp học',
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                child: TextField(
                  controller: controllers[6],
                  readOnly: true,
                  decoration: InputDecoration(
                    enabledBorder: enabledBorder,
                    focusedBorder: focusedBorder,
                    hintText: 'Nhập ngày khai giảng',
                  ),
                  onTap: () async {
                    DateTime? picked = await showDatePicker(
                      context: context,
                      initialDate: DateTime(2000),
                      firstDate: DateTime(1900),
                      lastDate: DateTime.now(),
                    );
                    if (picked != null) {
                      controllers[6].text =
                          "${picked.day}/${picked.month}/${picked.year}";
                    }
                  },
                ),
              ),
            ],
          ),
          ExpansionTile(
            title: const Text(
              '3. Lộ trình học lý thuyết',
              style: styleTitle,
            ),
            onExpansionChanged: (expanded) {},
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                child: TextField(
                  controller: controllers[7],
                  readOnly: true,
                  decoration: InputDecoration(
                    enabledBorder: enabledBorder,
                    focusedBorder: focusedBorder,
                    hintText: 'Nhập ngày tập trung',
                  ),
                  onTap: () async {
                    DateTime? picked = await showDatePicker(
                      context: context,
                      initialDate: DateTime(2000),
                      firstDate: DateTime(1900),
                      lastDate: DateTime.now(),
                    );
                    if (picked != null) {
                      controllers[7].text =
                          "${picked.day}/${picked.month}/${picked.year}";
                    }
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                child: TextField(
                  controller: controllers[8],
                  readOnly: true,
                  decoration: InputDecoration(
                    enabledBorder: enabledBorder,
                    focusedBorder: focusedBorder,
                    hintText: 'Nhập ngày học kiểm tra lý thuyết',
                  ),
                  onTap: () async {
                    DateTime? picked = await showDatePicker(
                      context: context,
                      initialDate: DateTime(2000),
                      firstDate: DateTime(1900),
                      lastDate: DateTime.now(),
                    );
                    if (picked != null) {
                      controllers[8].text =
                          "${picked.day}/${picked.month}/${picked.year}";
                    }
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                child: TextField(
                  controller: controllers[9],
                  readOnly: true,
                  decoration: InputDecoration(
                    enabledBorder: enabledBorder,
                    focusedBorder: focusedBorder,
                    hintText: 'Nhập ngày học cabin',
                  ),
                  onTap: () async {
                    DateTime? picked = await showDatePicker(
                      context: context,
                      initialDate: DateTime(2000),
                      firstDate: DateTime(1900),
                      lastDate: DateTime.now(),
                    );
                    if (picked != null) {
                      controllers[9].text =
                          "${picked.day}/${picked.month}/${picked.year}";
                    }
                  },
                ),
              ),
            ],
          ),
          ExpansionTile(
            title: const Text(
              '4. Lộ trình học thực hành',
              style: styleTitle,
            ),
            onExpansionChanged: (expanded) {},
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                child: TextField(
                  controller: controllers[10],
                  readOnly: true,
                  decoration: InputDecoration(
                    enabledBorder: enabledBorder,
                    focusedBorder: focusedBorder,
                    hintText: 'Nhập ngày học vỡ',
                  ),
                  onTap: () async {
                    DateTime? picked = await showDatePicker(
                      context: context,
                      initialDate: DateTime(2000),
                      firstDate: DateTime(1900),
                      lastDate: DateTime.now(),
                    );
                    if (picked != null) {
                      controllers[10].text =
                          "${picked.day}/${picked.month}/${picked.year}";
                    }
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                child: TextField(
                  controller: controllers[11],
                  readOnly: true,
                  decoration: InputDecoration(
                    enabledBorder: enabledBorder,
                    focusedBorder: focusedBorder,
                    hintText: 'Nhập ngày học sa hình',
                  ),
                  onTap: () async {
                    DateTime? picked = await showDatePicker(
                      context: context,
                      initialDate: DateTime(2000),
                      firstDate: DateTime(1900),
                      lastDate: DateTime.now(),
                    );
                    if (picked != null) {
                      controllers[11].text =
                          "${picked.day}/${picked.month}/${picked.year}";
                    }
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                child: TextField(
                  controller: controllers[12],
                  readOnly: true,
                  decoration: InputDecoration(
                    enabledBorder: enabledBorder,
                    focusedBorder: focusedBorder,
                    hintText: 'Nhập ngày học bổ túc thêm',
                  ),
                  onTap: () async {
                    DateTime? picked = await showDatePicker(
                      context: context,
                      initialDate: DateTime(2000),
                      firstDate: DateTime(1900),
                      lastDate: DateTime.now(),
                    );
                    if (picked != null) {
                      controllers[12].text =
                          "${picked.day}/${picked.month}/${picked.year}";
                    }
                  },
                ),
              ),
            ],
          ),
          ExpansionTile(
            title: const Text(
              '5. Thông tin bổ sung',
              style: styleTitle,
            ),
            onExpansionChanged: (expanded) {},
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                child: TextField(
                  controller: controllers[13],
                  decoration: InputDecoration(
                    enabledBorder: enabledBorder,
                    focusedBorder: focusedBorder,
                    hintText: 'Nhập ưu đãi 1',
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
