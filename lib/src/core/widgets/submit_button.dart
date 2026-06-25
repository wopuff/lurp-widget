import 'package:flutter/material.dart';

class SubmitButton extends StatelessWidget {
  final VoidCallback? action;
  final Size? size;

  const SubmitButton({super.key, this.action, this.size});

  @override
  Widget build(BuildContext context) {
    return SizedBox.fromSize(
      size: size ?? const Size.fromHeight(50),
      child: ElevatedButton(
        onPressed: action,
        style: ElevatedButton.styleFrom(
          backgroundColor: Theme.of(context).colorScheme.primary,
          surfaceTintColor: Theme.of(context).colorScheme.primary,
          foregroundColor: Theme.of(context).colorScheme.onPrimary,
          padding: EdgeInsets.zero,
          alignment: Alignment.center,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.5),
          ),
        ),
        child: Icon(
          Icons.arrow_upward,
          color: Theme.of(context).colorScheme.onPrimary,
          size: 25,
        ),
      ),
    );
  }
}
