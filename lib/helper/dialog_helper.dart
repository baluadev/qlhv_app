import 'package:flutter/material.dart';

import 'navigation_service.dart';

class DialogHelper {
  static void showLoading({String? title}) {
    _showGeneralDialog(
      Dialog(
        child: Container(
          padding: const EdgeInsets.all(10),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const CircularProgressIndicator(),
              const SizedBox(height: 10),
              Container(
                margin: const EdgeInsets.fromLTRB(10, 0, 0, 0),
                child: Text(
                  "${title ?? 'Loading'} ...",
                  style: const TextStyle(fontSize: 13),
                ),
              )
            ],
          ),
        ),
      ),
      barrierDismissible: false,
    );
  }

  static Future<void> hideLoading() async {
    await Future.delayed(const Duration(seconds: 1));
    back();
  }

  static void back() {
    final context = NavigationService.inst.curContext;
    if (Navigator.of(context).canPop()) {
      Navigator.of(context).pop();
    }
  }

  static dynamic _showGeneralDialog(
    Widget child, {
    bool barrierDismissible = true,
  }) {
    return showDialog(
      context: NavigationService.inst.curContext,
      barrierDismissible: barrierDismissible,
      builder: (c) {
        return child;
      },
    );
  }

  static showToast(message) {
    ScaffoldMessenger.of(NavigationService.inst.curContext).showSnackBar(
      SnackBar(
        content: Text(message),
      ),
    );
  }
}
