import 'dash_recorder_web.dart' if (dart.library.io) 'dash_recorder_mock.dart';

/// The **`DashRecorder`** class can safely be called in both web and native
/// builds since the conditional import will include the web version in web
/// and the mock version in native
class DashRecorder extends DashRecorderImpl {}
