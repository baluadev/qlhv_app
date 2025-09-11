abstract class HasText {
  String get text;
}

enum NguonHV implements HasText {
  trungtam,
  giaovien;

  @override
  String get text {
    switch (this) {
      case NguonHV.trungtam:
        return 'Nguồn trung tâm';
      case NguonHV.giaovien:
        return 'Nguồn giáo viên';
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
