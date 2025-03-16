import '../utils/dash_recorder/dash_recorder.dart';
import 'package:flutter/material.dart';

class DashMetaTag extends StatelessWidget {
  final String name;
  final String value;

  const DashMetaTag({required this.name, required this.value, super.key});

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) => _recordMetaData(context));

    return const SizedBox.shrink();
  }

  void _recordMetaData(BuildContext context) {
    final Map<String, dynamic> dashData = {"name": name, "value": value};
    DashRecorder().recordDashMetaTag(dashData);
  }

  factory DashMetaTag.title(String value) {
    return DashMetaTag(name: "title", value: value);
  }

  factory DashMetaTag.description(String value) {
    return DashMetaTag(name: "description", value: value);
  }

  factory DashMetaTag.keywords(List<String> value) {
    return DashMetaTag(name: "keywords", value: value.join(', '));
  }

  factory DashMetaTag.keywordsString(String value) {
    return DashMetaTag(name: "keywords", value: value);
  }

  factory DashMetaTag.image(String value) {
    return DashMetaTag(name: "og:image", value: value);
  }
}
