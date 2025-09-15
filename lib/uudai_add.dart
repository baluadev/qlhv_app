import 'package:flutter/material.dart';
import 'models/profile_model.dart';

class UuDaiAdd extends StatefulWidget {
  final String title;
  final List<UuDaiTime>? items;
  final Function(List<UuDaiTime>) onChanged;

  const UuDaiAdd({
    super.key,
    required this.onChanged,
    required this.title,
    this.items,
  });

  @override
  State<UuDaiAdd> createState() => _UuDaiAddState();
}

class _UuDaiAddState extends State<UuDaiAdd> {
  final List<Map<String, TextEditingController>> _rows = [];

  @override
  void initState() {
    super.initState();

    if (widget.items != null && widget.items!.isNotEmpty) {
      // Nếu có data truyền vào thì fill luôn
      for (var item in widget.items!) {
        _rows.add({
          "date": TextEditingController(text: item.date ?? ''),
          "content": TextEditingController(text: item.content ?? ''),
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
        "content": TextEditingController(text: ''),
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

  List<UuDaiTime> getData() {
    return _rows.map((row) {
      return UuDaiTime(
        date: row["date"]!.text,
        content: row["content"]!.text,
      );
    }).toList();
  }

  void _notifyParent() {
    setState(() {}); // để rebuild hiển thị tổng giờ & km
    widget.onChanged(getData());
  }

  Widget _cell(int index) {
    final row = _rows[index];
    const enabledBorder = OutlineInputBorder();
    const focusedBorder = OutlineInputBorder();

    return Padding(
      padding: const EdgeInsets.only(top: 8),
      child: Row(
        children: [
          Expanded(
            flex: 1,
            child: SizedBox(
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
          ),
          const SizedBox(width: 8),
          Expanded(
            flex: 2,
            child: SizedBox(
              height: 45,
              child: TextField(
                controller: row["content"],
                keyboardType: TextInputType.text,
                textAlign: TextAlign.center,
                decoration: const InputDecoration(
                  enabledBorder: enabledBorder,
                  focusedBorder: focusedBorder,
                  contentPadding: EdgeInsets.all(2),
                  hintText: 'Nhập nội dung',
                ),
                onChanged: (_) => _notifyParent(),
              ),
            ),
          ),
          IconButton(
            onPressed: () {
              if (index == _rows.length - 1) {
                _addRow();
              } else {
                _removeRow(index);
              }
            },
            icon: Icon(
              index == _rows.length - 1 ? Icons.add : Icons.remove,
              color: index == _rows.length - 1 ? Colors.green : Colors.red,
            ),
          )
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
        Padding(
          padding: const EdgeInsets.only(bottom: 5),
          child: Text(
            '${widget.title}:',
            style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
          ),
        ),
        ...List.generate(_rows.length, (index) => _cell(index)),
      ],
    );
  }
}
