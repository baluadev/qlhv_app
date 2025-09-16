import 'enums.dart';
import 'models/profile_model.dart';

class Utils {
  static int countCompleted(List<int?> list) {
    return list.where((element) => element == Status.passed.index).length;
  }

  static int getTotalHours({
    List<RowTime>? hocVo,
    List<RowTime>? chayDAT,
    List<RowTime>? saHinh,
  }) {
    final totalHocVo =
        (hocVo ?? []).fold<int>(0, (sum, item) => sum + (item.hour ?? 0));
    final totalChayDAT =
        (chayDAT ?? []).fold<int>(0, (sum, item) => sum + (item.hour ?? 0));
    final totalSaHinh =
        (saHinh ?? []).fold<int>(0, (sum, item) => sum + (item.hour ?? 0));

    return totalHocVo + totalChayDAT + totalSaHinh;
  }

  static int getTotalKm({
    List<RowTime>? hocVo,
    List<RowTime>? chayDAT,
    List<RowTime>? saHinh,
  }) {
    final totalHocVo =
        (hocVo ?? []).fold<int>(0, (sum, item) => sum + (item.km ?? 0));
    final totalChayDAT =
        (chayDAT ?? []).fold<int>(0, (sum, item) => sum + (item.km ?? 0));
    final totalSaHinh =
        (saHinh ?? []).fold<int>(0, (sum, item) => sum + (item.km ?? 0));

    return totalHocVo + totalChayDAT + totalSaHinh;
  }
}
