/// The **`DashRecorderInterface`**'s purpose is to allow for a web and mock
/// implementation so that web specific code is never triggered in native builds
abstract class DashRecorderInterface {
  /// Method to check if the recorder is enabled
  bool isEnabled();

  /// Method to record properties about a **`DashText`** widget
  void recordDashText(Map<String, dynamic> data);

  /// Method to record properties about a **`DashBox`** widget
  void recordDashBox(Map<String, dynamic> data);

  /// Method to record properties about a **`DashMetaTag`** widget
  void recordDashMetaTag(Map<String, dynamic> data);

  /// Method to tell dashhost the page is ready for capture
  void readyToCapture([int delay]);
}
