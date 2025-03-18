import 'package:dashhost_flutter/dashhost_flutter.dart';
import 'package:flutter/material.dart';

class DashReady extends StatelessWidget {
  const DashReady({super.key});

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      DashRecorder().readyToCapture();
    });
    return const SizedBox.shrink();
  }
}
