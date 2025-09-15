import 'package:flutter/material.dart';
import 'package:qlhv_app/helper/dialog_helper.dart';
import 'package:qlhv_app/models/profile_model.dart';
import 'package:qlhv_app/services/local_store.dart';

import 'date_textfield.dart';
import 'enums.dart';
import 'helper/drop_down_list/drop_down_list.dart';
import 'helper/drop_down_list/model/selected_list_item.dart';
import 'row_add.dart';
import 'status_widget.dart';
import 'tragop_add.dart';
import 'uudai_add.dart';

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

  List<RowTime> hocVoData = [];
  List<RowTime> chayDATData = [];
  List<RowTime> saHinhData = [];
  List<RowTime> hocChipData = [];
  int hocOnline = 2;
  int hocTapTrung = 2;
  int kiemtralythuyet = 2;
  int kiemtramophong = 2;
  int hoCabin = 2;
  int thiTotNghiep = 2;

  List<TraGopTime> traGopData = [];
  List<UuDaiTime> uudaiData = [];

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      final args = ModalRoute.of(context)!.settings.arguments;
      if (args is ProfileModel) {
        setState(() {
          profile = args;
          controllers[0].text = profile?.hovaten ?? "";
          controllers[1].text = profile?.ngaysinh ?? "";
          controllers[2].text = profile?.cccd ?? "";
          controllers[3].text = profile?.sdt ?? "";
          controllers[4].text = profile?.diachi ?? "";
          controllers[5].text = profile?.lophoc ?? "";
          controllers[6].text = profile?.ngaykhaigiang ?? "";
          controllers[13].text =
              ""; // ưu đãi 1 (nếu có field riêng thì map luôn)

          controllers2[0].text = profile?.nguonHV ?? ''; // Nguồn học viên
          controllers2[1].text = profile?.giaovienDAT ?? '';
          controllers2[2].text = profile?.xeDAT ?? '';
          controllers2[3].text = profile?.loaiHocPhi ?? '';
          controllers2[4].text = profile?.theGiaoVien ?? '';

          hocOnline = profile?.online ?? 2;
          hocTapTrung = profile?.taptrung ?? 2;
          kiemtralythuyet = profile?.kiemtralythuyet ?? 2;
          kiemtramophong = profile?.kiemtramophong ?? 2;
          hoCabin = profile?.cabin ?? 2;
          thiTotNghiep = profile?.thiTotNghiep ?? 2;

          hocVoData = profile?.hocVo ?? [];
          chayDATData = profile?.chayDAT ?? [];
          saHinhData = profile?.saHinh ?? [];
          hocChipData = profile?.hocChip ?? [];
          controllers[8].text = profile?.note ?? "";
          controllers[9].text = profile?.ngayTotNghiep ?? '';
        });
      }
    });
  }

  int getLyThuyetValue(LyThuyet value) {
    switch (value) {
      case LyThuyet.online:
        return hocOnline;
      case LyThuyet.taptrung:
        return hocTapTrung;
      case LyThuyet.kiemtralythuyet:
        return kiemtralythuyet;
      case LyThuyet.kiemtramophong:
        return kiemtramophong;
      case LyThuyet.cabin:
        return hoCabin;
      default:
        return 2;
    }
  }

  void setLyThuyetValue(LyThuyet key, int value) {
    switch (key) {
      case LyThuyet.online:
        hocOnline = value;
        break;
      case LyThuyet.taptrung:
        hocTapTrung = value;
        break;
      case LyThuyet.kiemtralythuyet:
        kiemtralythuyet = value;
        break;
      case LyThuyet.kiemtramophong:
        kiemtramophong = value;
        break;
      case LyThuyet.cabin:
        hoCabin = value;
        break;
      default:
        break;
    }
  }

  @override
  void dispose() {
    controllers.map((e) => e.dispose());
    controllers2.map((e) => e.dispose());
    super.dispose();
  }

  void addData(
    String key,
    Map data,
  ) =>
      data[key] = data;

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

  final GlobalKey<MainBodyState> dropDownKey = GlobalKey();

  List<String> getOptions(TypeNguon type) {
    switch (type) {
      case TypeNguon.teacher:
        return LocalStore.inst.getTeachers();
      case TypeNguon.car:
        return LocalStore.inst.getCars();
      case TypeNguon.card:
        return LocalStore.inst.getCards();
      default:
        return [];
    }
  }

  Future<void> addOptions(TypeNguon type, String value) async {
    switch (type) {
      case TypeNguon.teacher:
        await LocalStore.inst.addTeacher(value);
        break;
      case TypeNguon.car:
        await LocalStore.inst.addCar(value);
        break;
      case TypeNguon.card:
        await LocalStore.inst.addCard(value);
        break;
      default:
        break;
    }
  }

  void editOptions(TypeNguon type, int index, String value) {
    switch (type) {
      case TypeNguon.teacher:
        LocalStore.inst.editTeacher(index, value);
        break;
      case TypeNguon.car:
        LocalStore.inst.editCar(index, value);
        break;
      case TypeNguon.card:
        LocalStore.inst.editCard(index, value);
        break;
      default:
        break;
    }
  }

  Future<void> removeOptions(TypeNguon type, String value) async {
    switch (type) {
      case TypeNguon.teacher:
        await LocalStore.inst.removeTeacher(value);
        if (getOptions(type).isEmpty) {
          controllers2[1].text = '';
        }
        break;
      case TypeNguon.car:
        await LocalStore.inst.removeCar(value);
        if (getOptions(type).isEmpty) {
          controllers2[2].text = '';
        }
        break;
      case TypeNguon.card:
        await LocalStore.inst.removeCard(value);
        if (getOptions(type).isEmpty) {
          controllers2[4].text = '';
        }
        break;
      default:
        break;
    }
  }

  void onTextFieldTap2(TypeNguon type, TextEditingController controller) {
    DropDownState<String>(
      dropDown: DropDown<String>(
        key: dropDownKey,
        enableAdd: true,
        addButtonText: 'Thêm mới',
        onAddButtonPressed: () async {
          final result = await _showInputDialog('Thêm mới');
          if (result != null && result.isNotEmpty) {
            setState(() {
              addOptions(type, result);
              controller.text = result;
            });
            Navigator.pop(context);
          }
        },
        searchHintText: 'Tìm kiếm',
        data: getOptions(type)
            .map((e) => SelectedListItem<String>(
                  data: e,
                ))
            .toList(),
        listItemBuilder: (index, dataItem) => Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(dataItem.data),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  icon: const Icon(Icons.edit, size: 16),
                  onPressed: () async {
                    final result =
                        await _showInputDialog('Chỉnh sửa', dataItem.data);
                    if (result != null && result.isNotEmpty) {
                      setState(() {
                        editOptions(type, index, result);
                        controller.text = result;
                      });
                      Navigator.pop(context);
                    }
                  },
                ),
                IconButton(
                  icon: const Icon(
                    Icons.delete,
                    size: 16,
                    color: Colors.red,
                  ),
                  onPressed: () async {
                    removeOptions(type, dataItem.data);
                    Navigator.pop(context);
                  },
                ),
              ],
            )
          ],
        ),
        onSelected: (selectedItems) {
          if (selectedItems.isNotEmpty) {
            controller.text = selectedItems.first.data;
          }
        },
      ),
    ).showModal(context);
  }

  Future<String?> _showInputDialog(String title, [String? initialValue]) async {
    final controller = TextEditingController(text: initialValue);
    return await showDialog<String>(
      context: context,
      builder: (ctx) {
        return AlertDialog(
          title: Text(title),
          content: TextField(controller: controller, autofocus: true),
          actions: [
            TextButton(
                onPressed: () => Navigator.pop(ctx), child: const Text('Hủy')),
            TextButton(
                onPressed: () => Navigator.pop(ctx, controller.text),
                child: const Text('OK')),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    const enabledBorder = OutlineInputBorder();
    const focusedBorder = OutlineInputBorder();
    const styleTitle = TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.bold,
    );

    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text("${profile == null ? 'Thêm' : 'Sửa'} thông tin học viên"),
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
                    decoration: const InputDecoration(
                      enabledBorder: enabledBorder,
                      focusedBorder: focusedBorder,
                      hintText: 'Nhập họ và tên',
                    ),
                  ),
                ),
                DateTextField(
                  controller: controllers[1],
                  hintText: 'Nhập ngày sinh',
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                  child: TextField(
                    controller: controllers[2],
                    keyboardType: TextInputType.number,
                    maxLength: 12,
                    decoration: const InputDecoration(
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
                    decoration: const InputDecoration(
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
                    decoration: const InputDecoration(
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
                    decoration: const InputDecoration(
                      enabledBorder: enabledBorder,
                      focusedBorder: focusedBorder,
                      hintText: 'Nhập lớp học',
                    ),
                  ),
                ),
                DateTextField(
                  controller: controllers[6],
                  hintText: 'Nhập ngày khai giảng',
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                  child: AppTextField(
                    textEditingController: controllers2[0],
                    title: 'Nguồn học viên',
                    hint: 'Chọn nguồn học viên',
                    isReadOnly: true,
                    onTextFieldTap: () => onTextFieldTap<NguonHV>(
                        NguonHV.values, controllers2[0]),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                  child: AppTextField(
                    textEditingController: controllers2[1],
                    title: 'Giáo viên dạy DAT',
                    hint: 'Chọn giáo viên dạy DAT',
                    isReadOnly: true,
                    onTextFieldTap: () => onTextFieldTap2(
                      TypeNguon.teacher,
                      controllers2[1],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                  child: AppTextField(
                    textEditingController: controllers2[4],
                    title: 'Thẻ Giáo viên',
                    hint: 'Nhập thẻ giáo viên',
                    isReadOnly: true,
                    onTextFieldTap: () => onTextFieldTap2(
                      TypeNguon.card,
                      controllers2[4],
                    ),
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
                        onTextFieldTap2(TypeNguon.car, controllers2[2]),
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
                if (controllers2[3].text == LoaiHocPhi.tragop.text)
                  Padding(
                    padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                    child: TraGopAdd(
                      title: 'Trả góp',
                      items: profile?.traGop,
                      onChanged: (p0) {
                        traGopData = p0;
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
                ...LyThuyet.values.map(
                  (e) => Padding(
                    padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                    child: StatusWidget(
                      title: e.text,
                      value: getLyThuyetValue(e),
                      onChanged: (p0) {
                        setLyThuyetValue(e, p0);
                      },
                    ),
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
                  child: RowAdd(
                    title: 'Học Vỡ',
                    items: hocVoData,
                    onChanged: (p0) {
                      hocVoData = p0;
                    },
                  ),
                ),
                const SizedBox(height: 8),
                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                  child: RowAdd(
                    title: 'Chạy DAT',
                    enabledKm: true,
                    items: chayDATData,
                    onChanged: (p0) {
                      chayDATData = p0;
                    },
                  ),
                ),
                const SizedBox(height: 8),
                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                  child: RowAdd(
                    title: 'Học Sa hình',
                    items: saHinhData,
                    onChanged: (p0) {
                      saHinhData = p0;
                    },
                  ),
                ),
                const SizedBox(height: 8),
                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                  child: RowAdd(
                    title: 'Học Chip',
                    items: hocChipData,
                    onChanged: (p0) {
                      hocChipData = p0;
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                  child: StatusWidget(
                    title: 'Thi tốt nghiệp',
                    onChanged: (p0) {
                      thiTotNghiep = p0;
                    },
                  ),
                ),
                DateTextField(
                  controller: controllers[9],
                  hintText: 'Nhập ngày tốt nghiệp',
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
                  child: UuDaiAdd(
                    title: 'Ưu đãi',
                    items: profile?.uudai,
                    onChanged: (p0) {
                      uudaiData = p0;
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                  child: TextField(
                    controller: controllers[8],
                    decoration: const InputDecoration(
                      enabledBorder: enabledBorder,
                      focusedBorder: focusedBorder,
                      hintText:
                          'ghi chú', // thêm ưu đãi nhiều dòng (text area), thêm checkbox
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
              final newProfile = ProfileModel(
                profileId: profile?.profileId,
                hovaten: controllers[0].text,
                ngaysinh: controllers[1].text,
                cccd: controllers[2].text,
                sdt: controllers[3].text,
                diachi: controllers[4].text,
                lophoc: controllers[5].text,
                ngaykhaigiang: controllers[6].text,
                nguonHV: controllers2[0].text,
                giaovienDAT: controllers2[1].text,
                xeDAT: controllers2[2].text,
                loaiHocPhi: controllers2[3].text,
                theGiaoVien: controllers2[4].text,
                traGop: traGopData,
                online: hocOnline,
                taptrung: hocTapTrung,
                kiemtralythuyet: kiemtralythuyet,
                kiemtramophong: kiemtramophong,
                cabin: hoCabin,
                hocVo: hocVoData,
                chayDAT: chayDATData,
                saHinh: saHinhData,
                hocChip: hocChipData,
                thiTotNghiep: thiTotNghiep,
                ngayTotNghiep: controllers[9].text,
                uudai: uudaiData,
                note: controllers[8].text,
              );
              if (profile == null) {
                await _profileModel.add(newProfile);
              } else {
                await _profileModel.update(profile!.profileId!, newProfile);
              }

              await Future.delayed(const Duration(milliseconds: 300));
              DialogHelper.hideLoading();
              Navigator.pop(context);
            },
            child: Text(profile == null ? 'Lưu' : 'Cập nhật'),
          ),
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
