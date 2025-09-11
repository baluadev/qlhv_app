import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:qlhv_app/const.dart';
import 'package:qlhv_app/helper/dialog_helper.dart';
import 'package:qlhv_app/services/local_store.dart';

class ProfileModel {
  final String? hovaten;
  final String? ngaysinh;
  final String? cccd;
  final String? sdt;
  final String? diachi;
  final String? lophoc;
  final String? ngaykhaigiang;
  final int? nguonHV;
  final int? giaovienDAT;
  final int? xeDAT;
  final int? loaiHocPhi;
  final String? ngaytaptrung;
  final String? ngayhockiemtralythuyet;
  final String? ngayhoccabin;
  final String? ngayhocvo;
  final String? ngayhocsahinh;
  final String? ngayhobotucthem;

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
    this.ngaytaptrung,
    this.ngayhockiemtralythuyet,
    this.ngayhoccabin,
    this.ngayhocvo,
    this.ngayhocsahinh,
    this.ngayhobotucthem,
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
      nguonHV: json['nguonHV'] as int?,
      giaovienDAT: json['giaovienDAT'] as int?,
      xeDAT: json['xeDAT'] as int?,
      loaiHocPhi: json['loaiHocPhi'] as int?,
      ngaytaptrung: json['ngaytaptrung'] as String?,
      ngayhockiemtralythuyet: json['ngayhockiemtralythuyet'] as String?,
      ngayhoccabin: json['ngayhoccabin'] as String?,
      ngayhocvo: json['ngayhocvo'] as String?,
      ngayhocsahinh: json['ngayhocsahinh'] as String?,
      ngayhobotucthem: json['ngayhobotucthem'] as String?,
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
      'ngaytaptrung': ngaytaptrung,
      'ngayhockiemtralythuyet': ngayhockiemtralythuyet,
      'ngayhoccabin': ngayhoccabin,
      'ngayhocvo': ngayhocvo,
      'ngayhocsahinh': ngayhocsahinh,
      'ngayhobotucthem': ngayhobotucthem,
    };
  }

  @override
  String toString() {
    return jsonEncode(toJson());
  }

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
