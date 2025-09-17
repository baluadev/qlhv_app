import 'package:flutter/material.dart';
import 'package:qlhv_app/enums.dart';
import 'models/profile_model.dart';
import 'extentions.dart';
import 'status_widget.dart';

class SatHachAdd extends StatefulWidget {
  final String title;
  final List<SatHachTime>? items;
  final Function(List<SatHachTime>) onChanged;

  const SatHachAdd({
    super.key,
    required this.onChanged,
    required this.title,
    this.items,
  });

  @override
  State<SatHachAdd> createState() => _SatHachAddState();
}

class _SatHachAddState extends State<SatHachAdd> {
  final List<Map<String, dynamic>> _rows = [];

  @override
  void initState() {
    super.initState();

    if (widget.items != null && widget.items!.isNotEmpty) {
      // Nếu có data truyền vào thì fill luôn
      for (var item in widget.items!) {
        _rows.add({
          "date": TextEditingController(text: item.date ?? ''),
          "lyThuyet": item.lyThuyet ?? 2,
          'moPhong': item.moPhong ?? 2,
          'saHinh': item.saHinh ?? 2,
          'duongTruong': item.duongTruong ?? 2,
        });
      }
    } else {
      _addRow(); // Nếu không có data thì tạo 1 row mặc định
    }

    _notifyParent();
  }

  void _addRow() {
    final now = DateTime.now();
    setState(() {
      _rows.add({
        "date":
            TextEditingController(text: '${now.day}/${now.month}/${now.year}'),
        "lyThuyet": 2,
        'moPhong': 2,
        'saHinh': 2,
        'duongTruong': 2,
      });
    });
    _notifyParent();
  }

  void _removeRow(int index) {
    setState(() {
      _rows.removeAt(index);
    });
    _notifyParent();
  }

  List<SatHachTime> getData() {
    return _rows.map((row) {
      return SatHachTime(
        date: row["date"]!.text,
        lyThuyet: row["lyThuyet"],
        moPhong: row['moPhong'],
        saHinh: row['saHinh'],
        duongTruong: row['duongTruong'],
      );
    }).toList();
  }

  void _notifyParent() {
    setState(() {}); // để rebuild hiển thị tổng giờ & km
    print(getData());
    widget.onChanged(getData());
  }

  Widget _cell(int index) {
    final row = _rows[index];
    const enabledBorder = OutlineInputBorder();
    const focusedBorder = OutlineInputBorder();
    final lastItem = index == _rows.length - 1;
    return Container(
      padding: const EdgeInsets.all(5),
      decoration: BoxDecoration(
        border: Border.all(),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Thi lần ${index + 1}:',
            style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: 45,
            child: TextField(
              controller: row["date"],
              readOnly: true,
              textAlign: TextAlign.center,
              decoration: const InputDecoration(
                enabledBorder: enabledBorder,
                focusedBorder: focusedBorder,
                hintText: 'Nhập ngày',
                contentPadding: EdgeInsets.all(2),
              ),
              onTap: () async {
                DateTime? picked = await showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime(1900),
                  lastDate: DateTime.now(),
                  locale: const Locale("vi", "VN"),
                );
                if (picked != null) {
                  row["date"]!.text =
                      "${picked.day}/${picked.month}/${picked.year}";
                  _notifyParent();
                }
              },
              onChanged: (_) => _notifyParent(),
            ),
          ),
          ...SatHach.values.map(
            (e) => StatusWidget(
              title: e.text,
              value: row[e.name],
              onChanged: (p0) {
                row[e.name] = p0;
                _notifyParent();
              },
            ),
          ),
          InkWell(
            onTap: () {
              if (index == _rows.length - 1) {
                _addRow();
              } else {
                _removeRow(index);
              }
            },
            child: Container(
              height: 40,
              width: double.infinity,
              decoration: BoxDecoration(
                color: (lastItem ? Colors.green : Colors.red).withOpacity(0.1),
                borderRadius: BorderRadius.circular(5),
              ),
              alignment: Alignment.center,
              child: Text(
                lastItem ? 'Thêm mới' : 'Xóa',
                style: TextStyle(
                  color: lastItem ? Colors.green : Colors.red,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        ...List.generate(_rows.length, (index) => _cell(index)),
      ],
    );
  }
}
