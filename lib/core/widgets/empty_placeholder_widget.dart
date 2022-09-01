import 'package:my_template/core/l10n/string_hardcoded.dart';
import 'package:flutter/material.dart';
import 'package:my_template/core/widgets/primary_button_widget.dart';
import 'package:my_template/core/constants/app_sizes.dart';
import 'package:my_template/core/routers/fluro_navigator.dart';
import 'package:my_template/features/module_A/screen/todo/router/todo_router.dart';

/// Placeholder widget showing a message and CTA to go back to the home screen.
class EmptyPlaceholderWidget extends StatelessWidget {
  const EmptyPlaceholderWidget({super.key, required this.message});
  final String message;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(Sizes.p16),
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              message,
              style: Theme.of(context).textTheme.headlineMedium,
              textAlign: TextAlign.center,
            ),
            gapH32,
            PrimaryButton(
              onPressed: () => NavigatorUtils.push(context, TodoRouter.homePage),
              text: 'Go Home'.hardcoded,
            )
          ],
        ),
      ),
    );
  }
}
