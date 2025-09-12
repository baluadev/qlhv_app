import 'package:flutter/material.dart';
import 'package:qlhv_app/enums.dart';

class StatusWidget extends StatefulWidget {
  final String title;
  final int? value;
  final Function(int) onChanged;
  const StatusWidget({
    super.key,
    required this.title,
    this.value,
    required this.onChanged,
  });

  @override
  State<StatusWidget> createState() => _StatusWidgetState();
}

class _StatusWidgetState extends State<StatusWidget> {
  int select = 2;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (widget.value != null) {
      select = widget.value!;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 5),
          child: Text(
            widget.title,
            style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
          ),
        ),
        Row(
          children: Status.values.map((e) => _cell(e.text, e.index)).toList(),
        ),
      ],
    );
  }

  Widget _cell(String title, int index) {
    return Row(
      children: [
        Radio<int>(
          value: index, // mỗi radio có giá trị riêng
          activeColor: Colors.green,
          groupValue: select, // biến lưu giá trị đang chọn
          onChanged: (value) {
            if (value != null) {
              setState(() {
                select = value;
              });
              widget.onChanged(value);
            }
          },
        ),
        Text(title),
      ],
    );
  }
}
