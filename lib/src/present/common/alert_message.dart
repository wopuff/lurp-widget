import 'package:flutter/material.dart';
import 'package:lurp/src/core/theme/poll_colors.dart';
import 'package:lurp/src/domain/entities/return_data.dart';

class CustomAlertMessage {
  CustomAlertMessage({
    this.child,
    this.message,
    this.timerLength,
    this.borderColor,
    this.successColor = false,
    this.errorColor = false,
  });
  final Widget? child;
  final ReturnData? message;
  final int? timerLength;
  final Color? borderColor;
  final bool successColor;
  final bool errorColor;

  static void showNotSignedIn(BuildContext context) {
    CustomAlertMessage(
      message: ReturnData.notSignedInError(),
      borderColor: Colors.amber,
    ).show(context);
  }

  static OverlayEntry? _overlayEntry;
  static ReturnData? currentMessage;
  static AlertMessageWidgetState? _currentMessageState;
  static const int defaultTimerLength = 6000;

  void show(BuildContext context) async {
    if (message == null) return;

    if (currentMessage != null) {
      if (message == currentMessage || message!.equals(currentMessage!)) return;
      await hide(message: currentMessage!);
    }

    currentMessage = message;

    _overlayEntry = OverlayEntry(
      builder: (BuildContext context) => Positioned(
        top: 0,
        left: 0,
        right: 0,
        child: AlertMessageWidget(
          message: currentMessage!,
          onSlideInMessageStateCreated: (state) {
            _currentMessageState = state;
          },
          borderColor:
              borderColor ??
              (successColor
                  ? PollColors.green
                  : errorColor
                  ? PollColors.red
                  : null),
          child: child,
        ),
      ),
    );
    if (context.mounted) Overlay.of(context).insert(_overlayEntry!);

    Future.delayed(
      Duration(milliseconds: timerLength ?? defaultTimerLength),
      () => hide(message: message),
    );
  }

  static Future<void> hide({ReturnData? message}) async {
    message ??= currentMessage;

    if (message != currentMessage) return;

    if (_currentMessageState != null) {
      await _currentMessageState!.reverseSlide();
    }

    currentMessage = null;
    if (_overlayEntry != null) {
      _overlayEntry!.remove();
      _overlayEntry = null;
    }
  }

  static void showUpdate(BuildContext context, [String? title]) {
    CustomAlertMessage(
      message: ReturnData(
        title: title ?? 'Updating...',
        body: 'You can close this menu now.',
      ),
      timerLength: 2000,
    ).show(context);
  }

  static void showSuccess(BuildContext context, {String? body, String? value}) {
    CustomAlertMessage(
      message: ReturnData(
        title: 'Success!',
        body:
            body ??
            (value != null
                ? 'The value has been updated to $value'
                : 'The value has been updated'),
      ),
      timerLength: 2000,
      successColor: true,
    ).show(context);
  }
}

class AlertMessageWidget extends StatefulWidget {
  const AlertMessageWidget({
    super.key,
    this.child,
    required this.message,
    required this.onSlideInMessageStateCreated,
    this.borderColor,
  });
  final Widget? child;
  final ReturnData message;
  final Function(AlertMessageWidgetState) onSlideInMessageStateCreated;
  final Color? borderColor;

  @override
  AlertMessageWidgetState createState() => AlertMessageWidgetState();
}

class AlertMessageWidgetState extends State<AlertMessageWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
      reverseDuration: const Duration(milliseconds: 250),
    );
    _slideAnimation =
        Tween<Offset>(
          begin: const Offset(0, -1),
          end: const Offset(0, 0),
        ).animate(
          CurvedAnimation(parent: _controller, curve: Curves.fastOutSlowIn),
        );

    _controller.forward();
    widget.onSlideInMessageStateCreated(this);
  }

  Future<void> reverseSlide() async {
    await _controller.reverse();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double contentMaxWidth = screenWidth <= 700 ? screenWidth : 600;

    return Material(
      color: Colors.transparent,
      child: SlideTransition(
        position: _slideAnimation,
        child: SafeArea(
          child: Center(
            child: Container(
              padding: EdgeInsets.zero,
              margin: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.surface,
                borderRadius: BorderRadius.circular(12.5),
                border: widget.borderColor != null
                    ? Border.all(color: widget.borderColor!, width: 2)
                    : null,
              ),
              constraints: BoxConstraints(maxWidth: contentMaxWidth + 20),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(
                        top: 9,
                        bottom: 13,
                        left: 17.5,
                        right: 12.5,
                      ),
                      child:
                          widget.child ??
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              if (widget.message.title.isNotEmpty)
                                Text(
                                  widget.message.title,
                                  style: Theme.of(context).textTheme.titleSmall,
                                  textAlign: TextAlign.left,
                                ),
                              if (widget.message.title.isNotEmpty &&
                                  widget.message.body.isNotEmpty)
                                const SizedBox(height: 3),
                              if (widget.message.body.isNotEmpty)
                                Text(
                                  widget.message.body,
                                  style: Theme.of(context).textTheme.bodyMedium,
                                  textAlign: TextAlign.left,
                                ),
                            ],
                          ),
                    ),
                  ),
                  IconButton(
                    onPressed: () =>
                        CustomAlertMessage.hide(message: widget.message),
                    icon: Icon(
                      Icons.close,
                      color: Theme.of(context).colorScheme.onSurface,
                      size: 16,
                    ),
                    padding: EdgeInsets.zero,
                    alignment: Alignment.center,
                    style: IconButton.styleFrom(
                      fixedSize: const Size(30, 30),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.5),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
