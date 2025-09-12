abstract class HasText {
  String get text;
}

enum NguonHV implements HasText {
  trungtam,
  giaovien,
  sosan;

  @override
  String get text {
    switch (this) {
      case NguonHV.trungtam:
        return 'Nguồn trung tâm';
      case NguonHV.giaovien:
        return 'Nguồn giáo viên';
      case NguonHV.sosan:
        return 'Nguồn số sàn';
      default:
        return 'Nguồn trung tâm';
    }
  }
}

enum GiaoVienDAT implements HasText {
  giaovienA,
  giaovienB;

  @override
  String get text {
    switch (this) {
      case GiaoVienDAT.giaovienA:
        return 'Giáo viên A';
      case GiaoVienDAT.giaovienB:
        return 'Giáo viên B';
      default:
        return 'Giáo viên A';
    }
  }
}

enum XeDAT implements HasText {
  xeA,
  xeB;

  @override
  String get text {
    switch (this) {
      case XeDAT.xeA:
        return 'Xe A';
      case XeDAT.xeB:
        return 'Xe B';
      default:
        return 'Xe A';
    }
  }
}

//chỉ hiện thị khi nguồn học viên là giao viên
enum LoaiHocPhi implements HasText {
  full,
  coban,
  tragop;

  @override
  String get text {
    switch (this) {
      case LoaiHocPhi.full:
        return 'Gói Full';
      case LoaiHocPhi.coban:
        return 'Gói cơ bản';
      case LoaiHocPhi.tragop:
        return 'Gói trả góp';
      default:
        return 'Gói cơ bản';
    }
  }
}

enum QuaTrinhHoc {
  lythuyet,
  thuchanh,
  pass,
  failed,
}

enum LyThuyet {
  online,
  taptrung,
  kiemtralythuyet,
  kiemtramophong,
  cabin,
}

enum ThucHanh {
  hocvo,
  chayDAT,
  saHinh,
  thiTotNghiep,
  hocChip,
}

enum Status {
  passed,
  failed,
  none,
}
