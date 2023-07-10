import 'package:flutter/material.dart';

extension BuildContextEx on BuildContext {
  ThemeData get theme => Theme.of(this);

  // void showSnackbar(SnackBar snackBar) => ScaffoldMessenger.of(this).showSnackBar(snackBar);
  // void showErrorSnack(Failure failure) => showSnackbar(SnackBar(content: Text(failure.message)));
  // void showSuccessSnack(String? message) => showSnackbar(SnackBar(content: Text(message ?? Str.successfulOperation)));
}
