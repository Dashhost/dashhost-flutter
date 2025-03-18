import 'dart:convert';
import 'dart:js_interop';
import 'dart:js_interop_unsafe';
import 'dash_recorder_interface.dart';
import 'package:web/web.dart' as web;

/// Web implemention for **`DashRecorder`**
/// This uses the web package to broadcast updates to the JS layer
class DashRecorderImpl implements DashRecorderInterface {
  @override
  bool isEnabled() {
    final window = web.window;
    if (window.hasProperty('dashRecordingEnabled'.toJS) == true.toJS) {
      return window.getProperty('dashRecordingEnabled'.toJS) == true.toJS;
    }
    return false;
  }

  @override
  void recordDashText(Map<String, dynamic> data) {
    if (!isEnabled()) return;
    final window = web.window;

    if (window.hasProperty('recordDashText'.toJS) == true.toJS) {
      window.callMethod('recordDashText'.toJS, jsonEncode(data).toJS);
    }
  }

  @override
  void recordDashBox(Map<String, dynamic> data) {
    if (!isEnabled()) return;
    final window = web.window;

    if (window.hasProperty('recordDashBox'.toJS) == true.toJS) {
      window.callMethod('recordDashBox'.toJS, jsonEncode(data).toJS);
    }
  }

  @override
  void recordDashMetaTag(Map<String, dynamic> data) {
    if (!isEnabled()) return;
    final window = web.window;

    if (window.hasProperty('recordDashMetaTag'.toJS) == true.toJS) {
      window.callMethod('recordDashMetaTag'.toJS, jsonEncode(data).toJS);
    }
  }

  @override
  void readyToCapture() {
    if (!isEnabled()) return;

    final window = web.window;

    window.callMethod('dispatchEvent(new Event("dashReadyToCapture"))'.toJS);
  }
}
