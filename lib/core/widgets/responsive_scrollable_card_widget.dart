import 'package:my_template/core/constants/breakpoints.dart';
import 'package:flutter/material.dart';
import 'package:my_template/core/widgets/responsive_center_widget.dart';

import '../constants/dimens.dart';

/// Scrollable widget that shows a responsive card with a given child widget.
/// Useful for displaying forms and other widgets that need to be scrollable.
class ResponsiveScrollableCard extends StatelessWidget {
  const ResponsiveScrollableCard({super.key, required this.child});
  final Widget child;
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: ResponsiveCenter(
        maxContentWidth: Breakpoint.tablet,
        child: Padding(
          padding: const EdgeInsets.all(Dimens.gap_p16),
          child: Card(
            child: Padding(
              padding: const EdgeInsets.all(Dimens.gap_p16),
              child: child,
            ),
          ),
        ),
      ),
    );
  }
}
