extension StringParseSafe on String {
  int toIntSafe() {
    return int.tryParse(this) ?? 0;
  }
}
