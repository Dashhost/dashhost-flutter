import 'dash_recorder_interface.dart';

/// Mock implementation of **`DashRecorder`** for native builds
/// This intentionally does nothing
class DashRecorderImpl implements DashRecorderInterface {
  @override
  bool isEnabled() {
    return false;
  }

  @override
  void recordDashBox(Map<String, dynamic> data) {
    return;
  }

  @override
  void recordDashText(Map<String, dynamic> data) {
    return;
  }

  @override
  void recordDashMetaTag(Map<String, dynamic> data) {
    return;
  }
}
