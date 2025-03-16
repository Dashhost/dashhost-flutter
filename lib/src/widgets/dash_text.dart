import 'package:dashhost_flutter/dashhost_flutter.dart';

import '../utils/dash_recorder/dash_recorder.dart';
import 'package:flutter/material.dart';

class DashText extends StatelessWidget {
  final String text;
  final TextStyle? style;
  final TextAlign? textAlign;
  final TextDirection? textDirection;
  final Locale? locale;
  final bool? softWrap;
  final TextOverflow? overflow;
  final TextScaler? textScaler;
  final int? maxLines;
  final String? semanticsLabel;
  final TextWidthBasis? textWidthBasis;
  final TextHeightBehavior? textHeightBehavior;

  final String dashTag;
  final int? dashTTL;

  const DashText(
    this.text, {
    this.style,
    this.textAlign,
    this.textDirection,
    this.locale,
    this.softWrap,
    this.overflow,
    this.textScaler,
    this.maxLines,
    this.semanticsLabel,
    this.textWidthBasis,
    this.textHeightBehavior,
    this.dashTag = "p",
    this.dashTTL,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    if (!DashRecorder().isEnabled()) {
      return Text(
        text,
        style: style,
        textAlign: textAlign,
        textDirection: textDirection,
        locale: locale,
        softWrap: softWrap,
        overflow: overflow,
        textScaler: textScaler,
        maxLines: maxLines,
        semanticsLabel: semanticsLabel,
        textWidthBasis: textWidthBasis,
        textHeightBehavior: textHeightBehavior,
      );
    }

    return LayoutBuilder(
      builder: (context, constraints) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          _recordWidgetData(context);
          DashDevTools().refreshOverlay();
        });

        return Text(
          text,
          style: style,
          textAlign: textAlign,
          textDirection: textDirection,
          locale: locale,
          softWrap: softWrap,
          overflow: overflow,
          textScaler: textScaler,
          maxLines: maxLines,
          semanticsLabel: semanticsLabel,
          textWidthBasis: textWidthBasis,
          textHeightBehavior: textHeightBehavior,
        );
      },
    );
  }

  void _recordWidgetData(BuildContext context) {
    final renderBox = context.findRenderObject() as RenderBox?;
    if (renderBox != null) {
      final offset = renderBox.localToGlobal(Offset.zero);
      final width = renderBox.size.width;
      final height = renderBox.size.height;

      final Map<String, dynamic> dashData = {
        "x": offset.dx,
        "y": offset.dy,
        "width": width,
        "height": height,
        "text": text,
        'dashTag': dashTag,
        "dashTTL": dashTTL,
      };

      DashRecorder().recordDashText(dashData);
    }
  }
}
