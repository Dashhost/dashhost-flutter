abstract class DashRecorderInterface {
  bool isEnabled();
  void recordDashText(Map<String, dynamic> data);
  void recordDashBox(Map<String, dynamic> data);
}
