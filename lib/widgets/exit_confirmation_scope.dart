import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';

class ExitConfirmationScope extends StatefulWidget {
  final GoRouter router;
  final Widget child;

  const ExitConfirmationScope({
    super.key,
    required this.router,
    required this.child,
  });

  @override
  State<ExitConfirmationScope> createState() => _ExitConfirmationScopeState();
}

class _ExitConfirmationScopeState extends State<ExitConfirmationScope> {
  bool _isShowingExitDialog = false;

  Future<void> _handleBackPressed() async {
    if (widget.router.canPop()) {
      widget.router.pop();
      return;
    }

    if (_isShowingExitDialog) {
      return;
    }

    _isShowingExitDialog = true;
    final shouldClose = await showDialog<bool>(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return AlertDialog(
          title: const Text('Close app?'),
          content: const Text('Are you sure you want to close this app?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(false),
              child: const Text('No'),
            ),
            FilledButton(
              onPressed: () => Navigator.of(context).pop(true),
              child: const Text('Yes'),
            ),
          ],
        );
      },
    );
    _isShowingExitDialog = false;

    if (!mounted || shouldClose != true) {
      return;
    }

    await SystemNavigator.pop();
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) {
        if (didPop) {
          return;
        }

        _handleBackPressed();
      },
      child: widget.child,
    );
  }
}
