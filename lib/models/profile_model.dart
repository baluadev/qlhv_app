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

class ProfileModel {
  final String? hovaten;
  final String? ngaysinh;
  final String? cccd;
  final String? sdt;
  final String? diachi;
  final String? lophoc;
  final String? ngaykhaigiang;
  final String? nguonHV;
  final String? giaovienDAT;
  final String? xeDAT;
  final String? loaiHocPhi;
  final int? online;
  final int? taptrung;
  final int? kiemtralythuyet;
  final int? kiemtramophong;
  final int? cabin;
  final List<RowTime>? hocVo;
  final List<RowTime>? chayDAT;
  final List<RowTime>? saHinh;
  final List<RowTime>? hocChip;
  ProfileModel({
    this.hovaten,
    this.ngaysinh,
    this.cccd,
    this.sdt,
    this.diachi,
    this.lophoc,
    this.ngaykhaigiang,
    this.nguonHV,
    this.giaovienDAT,
    this.xeDAT,
    this.loaiHocPhi,
    this.online,
    this.taptrung,
    this.kiemtralythuyet,
    this.kiemtramophong,
    this.cabin,
    this.hocVo,
    this.chayDAT,
    this.saHinh,
    this.hocChip,
  });

  factory ProfileModel.fromJson(Map<String, dynamic> json) {
    return ProfileModel(
      hovaten: json['hovaten'] as String?,
      ngaysinh: json['ngaysinh'] as String?,
      cccd: json['cccd'] as String?,
      sdt: json['sdt'] as String?,
      diachi: json['diachi'] as String?,
      lophoc: json['lophoc'] as String?,
      ngaykhaigiang: json['ngaykhaigiang'] as String?,
      nguonHV: json['nguonHV'] as String?,
      giaovienDAT: json['giaovienDAT'] as String?,
      xeDAT: json['xeDAT'] as String?,
      loaiHocPhi: json['loaiHocPhi'] as String?,
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
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'hovaten': hovaten,
      'ngaysinh': ngaysinh,
      'cccd': cccd,
      'sdt': sdt,
      'diachi': diachi,
      'lophoc': lophoc,
      'ngaykhaigiang': ngaykhaigiang,
      'nguonHV': nguonHV,
      'giaovienDAT': giaovienDAT,
      'xeDAT': xeDAT,
      'loaiHocPhi': loaiHocPhi,
      'online': online,
      'taptrung': taptrung,
      'kiemtralythuyet': kiemtralythuyet,
      'kiemtramophong': kiemtramophong,
      'cabin': cabin,
      'hocVo': hocVo?.map((e) => e.toJson()).toList(),
      'chayDAT': chayDAT?.map((e) => e.toJson()).toList(),
      'saHinh': saHinh?.map((e) => e.toJson()).toList(),
      'hocChip': hocChip?.map((e) => e.toJson()).toList(),
    };
  }

  @override
  String toString() => jsonEncode(toJson());

  Future<bool> add(ProfileModel profile) async {
    var url = Uri.http(Const.baseUrl, 'qlhv-car/us-central1/api/profile/add');
    final resp = await http.post(
      url,
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({
        'userId': LocalStore.inst.getUser()?.id ?? '',
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
      final url = Uri.http(
        Const.baseUrl,
        'qlhv-car/us-central1/api/profile/search/$userId',
        {'keyword': keyword}, // query string
      );
      print(userId);
      final resp = await http.get(url);
      print(resp.body);
      final data = json.decode(resp.body);
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
}
