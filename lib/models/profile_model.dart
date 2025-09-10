import 'dart:convert';

class ProfileModel {
  final String? hovaten;
  final String? ngaysinh;
  final String? cccd;
  final String? sdt;
  final String? diachi;
  final String? lophoc;
  final String? ngaykhaigiang;
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
}
