import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gods_eye/models/camera_data/CameraData.dart';
import 'package:hive/hive.dart';
import 'package:slide_container/slide_container.dart';
import 'package:slide_container/slide_container_controller.dart';

/// Handy version of the [SlideContainer] to pop pages with a slide.
class ClosePageSlideContainer extends StatefulWidget {
  final Widget child;
  final VoidCallback onSlideStarted;
  final VoidCallback onSlideCompleted;
  final VoidCallback onSlideCanceled;
  final ValueChanged<double> onSlide;
  final SlideContainerController controller;

  ClosePageSlideContainer({
    @required this.child,
    this.onSlideStarted,
    this.onSlideCompleted,
    this.onSlideCanceled,
    this.onSlide,
    this.controller,
  });

  @override
  ClosePageSlideContainerState createState() => ClosePageSlideContainerState();
}

class ClosePageSlideContainerState extends State<ClosePageSlideContainer> {
  double overlayOpacity = 1.0;

  double get maxSlideDistance => MediaQuery.of(context).size.height;

  double get minSlideDistanceToValidate => maxSlideDistance * 0.5;

  void onSlide(double verticalPosition) {
    if (mounted) {
      setState(() => overlayOpacity = (1.000912 -
              0.1701771 * verticalPosition +
              1.676138 * pow(verticalPosition, 2) -
              3.784127 * pow(verticalPosition, 3))
          .clamp(0.0, 1.0));
    }
    if (widget.onSlide != null) widget.onSlide(verticalPosition);
  }

  void onSlideCompleted() {
    if (widget.onSlideCompleted != null) widget.onSlideCompleted();
    Hive.box<CameraData>('cam')
        .get(0)
        .updateCurrentCamera(0); // To reset the selected camera's index.
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) => SlideContainer(
        controller: widget.controller,
        slideDirection: SlideContainerDirection.topToBottom,
        onSlide: onSlide,
        onSlideCompleted: onSlideCompleted,
        minDragVelocityForAutoSlide: 600.0,
        minSlideDistanceToValidate: minSlideDistanceToValidate,
        maxSlideDistance: maxSlideDistance,
        autoSlideDuration: const Duration(milliseconds: 300),
        onSlideStarted: widget.onSlideStarted,
        onSlideCanceled: widget.onSlideCanceled,
        onSlideValidated: () => HapticFeedback.mediumImpact(),
        child: Opacity(
          opacity: overlayOpacity,
          child: widget.child,
        ),
      );
}
