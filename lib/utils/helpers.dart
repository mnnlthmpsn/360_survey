import 'package:flutter/material.dart';
import 'package:survey/utils/constants.dart';

void newPage(BuildContext context, String routeName) {
  Navigator.pushNamed(context, routeName);
}

void newPageDestroyPrevious(BuildContext context, String routeName) {
  Navigator.pushReplacementNamed(context, routeName);
}

void newPageDestroyAll(BuildContext context, String routeName) {
  Navigator.of(context).pushNamedAndRemoveUntil(routeName, (route) => false);
}

void goBack(BuildContext context) {
  dismissKeyboard(context);
  Navigator.pop(context);
}

void dismissKeyboard(context) {
  FocusScopeNode currentFocus = FocusScope.of(context);
  if (!currentFocus.hasPrimaryFocus) {
    currentFocus.unfocus();
  }
}

void showSnackBar(BuildContext context, String message, String type) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      backgroundColor: type == 'success' ? Colors.green : Colors.red,
      content: Text(message,
          style: Theme.of(context).textTheme.subtitle2?.copyWith(
              color: Colors.white, fontSize: AppConstants.textSizeSmall))));
}
