import '../utils/dash_recorder/dash_recorder.dart';
import 'package:flutter/material.dart';

class DashBox extends StatelessWidget {
  final Widget child;
  final String dashTag;

  const DashBox({required this.child, this.dashTag = "div", super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        WidgetsBinding.instance.addPostFrameCallback((_) => _recordBoxData(context));
        return child;
      },
    );
  }

  void _recordBoxData(BuildContext context) {
    final renderBox = context.findRenderObject() as RenderBox?;
    if (renderBox != null) {
      final offset = renderBox.localToGlobal(Offset.zero);
      final width = renderBox.size.width;
      final height = renderBox.size.height;

      final Map<String, dynamic> dashData = {"x": offset.dx, "y": offset.dy, "width": width, "height": height, "dashTag": dashTag};

      DashRecorder().recordDashBox(dashData);
    }
  }
}
