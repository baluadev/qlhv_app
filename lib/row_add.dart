import 'package:flutter/material.dart';
import 'models/profile_model.dart';
import 'helper/extentions.dart';

class RowAdd extends StatefulWidget {
  final String title;
  final List<RowTime>? items;
  final bool? enabledKm;
  final Function(List<RowTime>) onChanged;

  const RowAdd({
    super.key,
    required this.onChanged,
    required this.title,
    this.enabledKm = false,
    this.items,
  });

  @override
  State<RowAdd> createState() => _RowAddState();
}

class _RowAddState extends State<RowAdd> {
  final List<Map<String, TextEditingController>> _rows = [];

  @override
  void initState() {
    super.initState();

    if (widget.items != null && widget.items!.isNotEmpty) {
      // Nếu có data truyền vào thì fill luôn
      for (var item in widget.items!) {
        _rows.add({
          "date": TextEditingController(text: item.date ?? ''),
          "hours": TextEditingController(text: '${item.hour ?? 0}'),
          "km": TextEditingController(text: '${item.km ?? 0}'),
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
        "hours": TextEditingController(text: '0'),
        "km": TextEditingController(text: '0'),
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

  List<RowTime> getData() {
    return _rows.map((row) {
      return RowTime(
        date: row["date"]!.text,
        hour: row["hours"]!.text.toIntSafe(),
        km: row["km"]!.text.toIntSafe(),
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
            flex: 4,
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
            flex: 3,
            child: SizedBox(
              height: 45,
              child: TextField(
                controller: row["hours"],
                keyboardType: TextInputType.number,
                textAlign: TextAlign.center,
                decoration: const InputDecoration(
                  enabledBorder: enabledBorder,
                  focusedBorder: focusedBorder,
                  contentPadding: EdgeInsets.all(2),
                  suffixIcon: Center(
                    widthFactor: 1.0,
                    child: Text(
                      'Giờ',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.black87,
                      ),
                    ),
                  ),
                ),
                onChanged: (_) => _notifyParent(),
              ),
            ),
          ),
          const SizedBox(width: 8),
          if (widget.enabledKm ?? true)
            Expanded(
              flex: 3,
              child: SizedBox(
                height: 45,
                child: TextField(
                  controller: row["km"],
                  keyboardType: TextInputType.number,
                  textAlign: TextAlign.center,
                  decoration: const InputDecoration(
                    enabledBorder: enabledBorder,
                    focusedBorder: focusedBorder,
                    contentPadding: EdgeInsets.all(2),
                    suffixIcon: Center(
                      widthFactor: 1.0,
                      child: Text(
                        'Km',
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.black87,
                        ),
                      ),
                    ),
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
    final totalHours = _rows.fold<int>(
      0,
      (sum, row) => sum + row["hours"]!.text.toIntSafe(),
    );

    final totalKm = _rows.fold<int>(
      0,
      (sum, row) => sum + row["km"]!.text.toIntSafe(),
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 5),
          child: Text(
            '${widget.title}: $totalHours giờ - $totalKm km',
            style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
          ),
        ),
        ...List.generate(_rows.length, (index) => _cell(index)),
      ],
    );
  }
}
