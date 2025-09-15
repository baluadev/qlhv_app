import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:qlhv_app/const.dart';
import 'package:qlhv_app/helper/dialog_helper.dart';
import 'package:qlhv_app/services/local_store.dart';

class RowTime {
  final String? date;
  final int? hour;
  final int? km;

  RowTime({
    this.date,
    this.hour,
    this.km,
  });

  /// Convert từ Map (json) sang RowTime
  factory RowTime.fromJson(Map<String, dynamic> json) {
    return RowTime(
      date: json['date'] as String?,
      hour:
          json['hour'] is int ? json['hour'] : int.tryParse('${json['hour']}'),
      km: json['km'] is int ? json['km'] : int.tryParse('${json['km']}'),
    );
  }

  /// Convert RowTime sang Map (json)
  Map<String, dynamic> toJson() {
    return {
      'date': date,
      'hour': hour,
      'km': km,
    };
  }

  @override
  String toString() {
    return 'RowTime(date: $date, hour: $hour, km: $km)';
  }
}

class TraGopTime {
  final String? date;
  final int? money;

  TraGopTime({
    this.date,
    this.money,
  });

  /// Convert từ Map (json) sang RowTime
  factory TraGopTime.fromJson(Map<String, dynamic> json) {
    return TraGopTime(
      date: json['date'] as String?,
      money: json['money'] is int
          ? json['money']
          : int.tryParse('${json['money']}'),
    );
  }

  /// Convert RowTime sang Map (json)
  Map<String, dynamic> toJson() {
    return {
      'date': date,
      'money': money,
    };
  }

  @override
  String toString() {
    return 'TraGopTime(date: $date, money: $money)';
  }
}

class UuDaiTime {
  final String? title;
  final String? content;
  final bool? checked;

  UuDaiTime({
    this.title,
    this.content,
    this.checked
  });

  /// Convert từ Map (json) sang RowTime
  factory UuDaiTime.fromJson(Map<String, dynamic> json) {
    return UuDaiTime(
      title: json['title'] as String?,
      content: json['content'] as String?,
      checked: json['checked'] as bool?,
    );
  }

  /// Convert RowTime sang Map (json)
  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'content': content,
      'checked': checked,
    };
  }

  @override
  String toString() {
    return 'UuDaiTime(title: $title, content: $content, checked: $checked)';
  }
}

class ProfileModel {
  final String? profileId;
  final String? hovaten;
  final String? ngaysinh;
  final String? cccd;
  final String? sdt;
  final String? diachi;
  final String? lophoc;
  final String? ngaykhaigiang;
  final String? nguonHV;
  final String? giaovienDAT;
  final String? theGiaoVien;
  final String? xeDAT;
  final String? loaiHocPhi;
  final List<TraGopTime>? traGop;
  final int? online;
  final int? taptrung;
  final int? kiemtralythuyet;
  final int? kiemtramophong;
  final int? cabin;
  final List<RowTime>? hocVo;
  final List<RowTime>? chayDAT;
  final List<RowTime>? saHinh;
  final List<RowTime>? hocChip;
  final int? thiTotNghiep;
  final String? ngayTotNghiep;
  final List<UuDaiTime>? uudai;
  final String? note;
  ProfileModel({
    this.profileId,
    this.hovaten,
    this.ngaysinh,
    this.cccd,
    this.sdt,
    this.diachi,
    this.lophoc,
    this.ngaykhaigiang,
    this.nguonHV,
    this.giaovienDAT,
    this.theGiaoVien,
    this.xeDAT,
    this.loaiHocPhi,
    this.traGop,
    this.online,
    this.taptrung,
    this.kiemtralythuyet,
    this.kiemtramophong,
    this.cabin,
    this.hocVo,
    this.chayDAT,
    this.saHinh,
    this.hocChip,
    this.thiTotNghiep,
    this.uudai,
    this.note,
    this.ngayTotNghiep,
  });

  factory ProfileModel.fromJson(Map<String, dynamic> json) {
    return ProfileModel(
      profileId: json['profileId'] as String?,
      hovaten: json['hovaten'] as String?,
      ngaysinh: json['ngaysinh'] as String?,
      cccd: json['cccd'] as String?,
      sdt: json['sdt'] as String?,
      diachi: json['diachi'] as String?,
      lophoc: json['lophoc'] as String?,
      ngaykhaigiang: json['ngaykhaigiang'] as String?,
      nguonHV: json['nguonHV'] as String?,
      giaovienDAT: json['giaovienDAT'] as String?,
      theGiaoVien: json['theGiaoVien'] as String?,
      xeDAT: json['xeDAT'] as String?,
      loaiHocPhi: json['loaiHocPhi'] as String?,
      traGop: (json['traGop'] as List<dynamic>?)
          ?.map((e) => TraGopTime.fromJson(e as Map<String, dynamic>))
          .toList(),
      online: json['online'] as int?,
      taptrung: json['taptrung'] as int?,
      kiemtralythuyet: json['kiemtralythuyet'] as int?,
      kiemtramophong: json['kiemtramophong'] as int?,
      cabin: json['cabin'] as int?,
      hocVo: (json['hocVo'] as List<dynamic>?)
          ?.map((e) => RowTime.fromJson(e as Map<String, dynamic>))
          .toList(),
      chayDAT: (json['chayDAT'] as List<dynamic>?)
          ?.map((e) => RowTime.fromJson(e as Map<String, dynamic>))
          .toList(),
      saHinh: (json['saHinh'] as List<dynamic>?)
          ?.map((e) => RowTime.fromJson(e as Map<String, dynamic>))
          .toList(),
      hocChip: (json['hocChip'] as List<dynamic>?)
          ?.map((e) => RowTime.fromJson(e as Map<String, dynamic>))
          .toList(),
      thiTotNghiep: json['thiTotNghiep'] as int?,
      uudai: (json['uudai'] as List<dynamic>?)
          ?.map((e) => UuDaiTime.fromJson(e as Map<String, dynamic>))
          .toList(),
      note: json['note'] as String?,
      ngayTotNghiep: json['ngayTotNghiep'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'profileId': profileId,
      'hovaten': hovaten,
      'ngaysinh': ngaysinh,
      'cccd': cccd,
      'sdt': sdt,
      'diachi': diachi,
      'lophoc': lophoc,
      'ngaykhaigiang': ngaykhaigiang,
      'nguonHV': nguonHV,
      'giaovienDAT': giaovienDAT,
      'theGiaoVien': theGiaoVien,
      'xeDAT': xeDAT,
      'loaiHocPhi': loaiHocPhi,
      'traGop': traGop?.map((e) => e.toJson()).toList(),
      'online': online,
      'taptrung': taptrung,
      'kiemtralythuyet': kiemtralythuyet,
      'kiemtramophong': kiemtramophong,
      'cabin': cabin,
      'hocVo': hocVo?.map((e) => e.toJson()).toList(),
      'chayDAT': chayDAT?.map((e) => e.toJson()).toList(),
      'saHinh': saHinh?.map((e) => e.toJson()).toList(),
      'hocChip': hocChip?.map((e) => e.toJson()).toList(),
      'thiTotNghiep': thiTotNghiep,
      'uudai': uudai?.map((e) => e.toJson()).toList(),
      'note': note,
      'ngayTotNghiep': ngayTotNghiep,
    };
  }

  @override
  String toString() => jsonEncode(toJson());

  Future<bool> add(ProfileModel profile) async {
    final url = Const.isDebug
        ? Uri.http(Const.baseUrl, 'qlhv-car/us-central1/api/profile/add')
        : Uri.https(Const.baseUrl, 'profile/add');
    final resp = await http.post(
      url,
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({
        'userId': LocalStore.inst.getUser()?.id ?? '',
        'profile': profile.toJson(),
      }),
    );
    print(resp.body);
    final data = json.decode(resp.body);
    if (resp.statusCode != 200) {
      final message = data['message'];
      DialogHelper.showToast(message);
      return false;
    }
    await Future.delayed(const Duration(seconds: 1));
    return true;
  }

  Future<bool> update(String profileId, ProfileModel profile) async {
    final url = Const.isDebug
        ? Uri.http(
            Const.baseUrl, 'qlhv-car/us-central1/api/profile/update/$profileId')
        : Uri.https(Const.baseUrl, 'profile/update/$profileId');
    final resp = await http.put(
      url,
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({
        'profile': profile.toJson(),
      }),
    );
    final data = json.decode(resp.body);
    if (resp.statusCode != 200) {
      final message = data['message'];
      DialogHelper.showToast(message);
      return false;
    }
    await Future.delayed(const Duration(seconds: 1));
    return true;
  }

  Future<List<ProfileModel>> search(String keyword) async {
    final userId = LocalStore.inst.getUser()?.id ?? '';
    try {
      final url = Const.isDebug
          ? Uri.http(
              Const.baseUrl,
              'qlhv-car/us-central1/api/profile/search/$userId',
              {'keyword': keyword},
            )
          : Uri.https(
              Const.baseUrl,
              'profile/search/$userId',
              {'keyword': keyword},
            );
      final resp = await http.get(url);
      final data = json.decode(resp.body);
      print(data);
      if (resp.statusCode != 200) {
        final message = data['message'] ?? "Có lỗi xảy ra";
        DialogHelper.showToast(message);
        return [];
      }

      final results = data['results'] as List<dynamic>;
      return results.map((e) => ProfileModel.fromJson(e)).toList();
    } catch (e) {
      print(e);
      return [];
    }
  }

  Future<ProfileModel?> getProfile(String profileId) async {
    try {
      print(profileId);
      final url = Const.isDebug
          ? Uri.http(
              Const.baseUrl,
              'qlhv-car/us-central1/api/profile/detail/$profileId',
            )
          : Uri.https(
              Const.baseUrl,
              'profile/detail/$profileId',
            );
      final resp = await http.get(url);
      print(resp.body);
      final data = json.decode(resp.body);

      if (resp.statusCode != 200) {
        final message = data['message'] ?? "Có lỗi xảy ra";
        DialogHelper.showToast(message);
        return null;
      }

      final results = data['profile'];
      return ProfileModel.fromJson(results);
    } catch (e) {
      print(e);
      return null;
    }
  }
}
