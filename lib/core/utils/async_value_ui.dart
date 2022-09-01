import 'package:my_template/core/widgets/alert_dialogs_widget.dart';
import 'package:my_template/core/exceptions/app_exception.dart';
import 'package:my_template/core/l10n/string_hardcoded.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

extension AsyncValueUI on AsyncValue {
  void showAlertDialogOnError(BuildContext context) {
    if (!isRefreshing && hasError) {
      final message = _errorMessage(error);
      showExceptionAlertDialog(
        context: context,
        title: 'Error'.hardcoded,
        exception: message,
      );
    }
  }

  String _errorMessage(Object? error) {
    if (error is AppException) {
      return error.details.message;
    } else {
      return error.toString();
    }
  }
}

// Bonus: define AsyncValue<void> as a typedef that we can
// reuse across multiple widgets and state notifiers
typedef VoidAsyncValue = AsyncValue<void>;

extension AsyncValueUISnackBar on VoidAsyncValue {
// isLoading shorthand (AsyncLoading is a subclass of AsycValue)
  bool get isLoading => this is AsyncLoading<void>;

// show a snackbar on error only
  void showSnackBarOnError(BuildContext context) => whenOrNull(
        error: (error, _) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(error.toString())),
          );
        },
      );

  void showMySnackBar(BuildContext context) {
    final snackBar = SnackBar(
      content: const Text('顯示訊息'),
      action: SnackBarAction(
        label: '復原',
        onPressed: () {
          debugPrint('復原...');
        },
      ),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
