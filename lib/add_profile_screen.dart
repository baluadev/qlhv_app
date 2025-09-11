import 'package:drop_down_list/drop_down_list.dart';
import 'package:drop_down_list/model/selected_list_item.dart';
import 'package:flutter/material.dart';
import 'package:qlhv_app/helper/dialog_helper.dart';
import 'package:qlhv_app/models/profile_model.dart';
import 'package:qlhv_app/services/local_store.dart';

import 'enums.dart';

class AddProfileScreen extends StatefulWidget {
  const AddProfileScreen({super.key});

  @override
  State<AddProfileScreen> createState() => _AddProfileScreenState();
}

class _AddProfileScreenState extends State<AddProfileScreen> {
  final ProfileModel _profileModel = ProfileModel();

  List<TextEditingController> controllers =
      List.generate(14, (index) => TextEditingController());
  List<TextEditingController> controllers2 =
      List.generate(10, (index) => TextEditingController());
  ProfileModel? profile;

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Lấy arguments từ route
    final args = ModalRoute.of(context)!.settings.arguments;
    if (args is ProfileModel) {
      profile = args;

      // Gán dữ liệu từ ProfileModel vào controllers
      controllers[0].text = profile?.hovaten ?? "";
      controllers[1].text = profile?.ngaysinh ?? "";
      controllers[2].text = profile?.cccd ?? "";
      controllers[3].text = profile?.sdt ?? "";
      controllers[4].text = profile?.diachi ?? "";
      controllers[5].text = profile?.lophoc ?? "";
      controllers[6].text = profile?.ngaykhaigiang ?? "";
      controllers[7].text = profile?.ngaytaptrung ?? "";
      controllers[8].text = profile?.ngayhockiemtralythuyet ?? "";
      controllers[9].text = profile?.ngayhoccabin ?? "";
      controllers[10].text = profile?.ngayhocvo ?? "";
      controllers[11].text = profile?.ngayhocsahinh ?? "";
      controllers[12].text = profile?.ngayhobotucthem ?? "";
      controllers[13].text = ""; // ưu đãi 1 (nếu có field riêng thì map luôn)

      //downlist      controllers2[0].text = ""; // Nguồn học viên
      // controllers2[0].text = profile?; // Nguồn học viên
    }
  }

  @override
  void dispose() {
    controllers.map((e) => e.dispose());
    controllers2.map((e) => e.dispose());
    super.dispose();
  }

  void onTextFieldTap<T extends HasText>(
      List<T> options, TextEditingController controller) {
    DropDownState<T>(
      dropDown: DropDown<T>(
        searchHintText: 'Tìm kiếm',
        data: options
            .map((e) => SelectedListItem<T>(
                  data: e,
                ))
            .toList(),
        listItemBuilder: (index, dataItem) => Text(dataItem.data.text),
        onSelected: (selectedItems) {
          if (selectedItems.isNotEmpty) {
            controller.text = selectedItems.first.data.text;
          }
        },
      ),
    ).showModal(context);
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
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                child: AppTextField(
                  textEditingController: controllers2[0],
                  title: 'Nguồn học viên',
                  hint: 'Chọn nguồn học viên',
                  isReadOnly: true,
                  onTextFieldTap: () =>
                      onTextFieldTap<NguonHV>(NguonHV.values, controllers2[0]),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                child: AppTextField(
                  textEditingController: controllers2[1],
                  title: 'Giáo viên dạy DAT',
                  hint: 'Chọn giáo viên dạy DAT',
                  isReadOnly: true,
                  onTextFieldTap: () => onTextFieldTap<GiaoVienDAT>(
                      GiaoVienDAT.values, controllers2[1]),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                child: AppTextField(
                  textEditingController: controllers2[2],
                  title: 'Xe dạy DAT',
                  hint: 'Chọn xe dạy DAT',
                  isReadOnly: true,
                  onTextFieldTap: () =>
                      onTextFieldTap<XeDAT>(XeDAT.values, controllers2[2]),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                child: AppTextField(
                  textEditingController: controllers2[3],
                  title: 'Cách thức đóng học phí',
                  hint: 'Chọn cách thức đóng học phí',
                  isReadOnly: true,
                  onTextFieldTap: () => onTextFieldTap<LoaiHocPhi>(
                      LoaiHocPhi.values, controllers2[3]),
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
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ElevatedButton(
          onPressed: () async {
            DialogHelper.showLoading();
            if (profile == null) {
              await _profileModel.add(ProfileModel(
                hovaten: controllers[0].text,
                ngaysinh: controllers[1].text,
                cccd: controllers[2].text,
                sdt: controllers[3].text,
                diachi: controllers[4].text,
                lophoc: controllers[5].text,
                ngaykhaigiang: controllers[6].text,
                ngaytaptrung: controllers[7].text,
                ngayhockiemtralythuyet: controllers[8].text,
                ngayhoccabin: controllers[9].text,
                ngayhocvo: controllers[10].text,
                ngayhocsahinh: controllers[11].text,
                ngayhobotucthem: controllers[12].text,
              ));
            } else {}
            await Future.delayed(const Duration(milliseconds: 300));
            DialogHelper.hideLoading();
            Navigator.pop(context);
          },
          child: Text(profile == null ? 'Lưu' : 'Cập nhật'),
        ),
      ),
    );
  }
}

class AppTextField extends StatefulWidget {
  final TextEditingController textEditingController;
  final String title;
  final String hint;
  final bool isReadOnly;
  final VoidCallback? onTextFieldTap;

  const AppTextField({
    required this.textEditingController,
    required this.title,
    required this.hint,
    this.isReadOnly = false,
    this.onTextFieldTap,
    super.key,
  });

  @override
  State<AppTextField> createState() => _AppTextFieldState();
}

class _AppTextFieldState extends State<AppTextField> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.title,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
        ),
        const SizedBox(height: 5.0),
        TextFormField(
          controller: widget.textEditingController,
          cursorColor: Colors.black,
          readOnly: widget.isReadOnly,
          onTap: widget.isReadOnly
              ? () {
                  FocusScope.of(context).unfocus();
                  widget.onTextFieldTap?.call();
                }
              : null,
          decoration: InputDecoration(
            filled: true,
            fillColor: Colors.black12,
            contentPadding: const EdgeInsets.only(
              left: 8,
              bottom: 0,
              top: 0,
              right: 15,
            ),
            hintText: widget.hint,
            border: const OutlineInputBorder(
              borderSide: BorderSide(
                width: 0,
                style: BorderStyle.none,
              ),
              borderRadius: BorderRadius.all(
                Radius.circular(8.0),
              ),
            ),
          ),
        ),
        const SizedBox(height: 15.0),
      ],
    );
  }
}
