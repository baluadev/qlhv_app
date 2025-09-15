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

enum TypeNguon {
  teacher,
  car,
  card,
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

enum LyThuyet implements HasText {
  online,
  taptrung,
  kiemtralythuyet,
  kiemtramophong,
  cabin;

  @override
  String get text {
    switch (this) {
      case LyThuyet.online:
        return 'Học Online';
      case LyThuyet.taptrung:
        return 'Học tập trung';
      case LyThuyet.kiemtralythuyet:
        return 'Kiểm tra lý thuyết';
      case LyThuyet.kiemtramophong:
        return 'Kiểm tra mô phỏng';
      case LyThuyet.cabin:
        return 'Học Cabin';
      default:
        return 'Không chọn';
    }
  }
}

enum ThucHanh implements HasText {
  hocvo,
  chayDAT,
  saHinh,
  thiTotNghiep,
  hocChip;

  @override
  String get text {
    switch (this) {
      case ThucHanh.hocvo:
        return 'Học Vỡ';
      case ThucHanh.chayDAT:
        return 'Chạy DAT';
      case ThucHanh.saHinh:
        return 'Học Sa Hình';
      case ThucHanh.hocChip:
        return 'Học Chip';
      case ThucHanh.thiTotNghiep:
        return 'Thi Tốt nghiệp';
      default:
        return 'Không chọn';
    }
  }
}

enum Status implements HasText {
  passed,
  failed,
  none;

  @override
  String get text {
    switch (this) {
      case Status.passed:
        return 'Hoàn thành';
      case Status.failed:
        return 'Trượt';
      case Status.none:
        return 'Không chọn';
      default:
        return 'Không chọn';
    }
  }
}
