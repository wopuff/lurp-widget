import 'package:flutter/material.dart';

// THIS WIDGET IS SERIOUSLY NOT WORKING PROPERLY. USE 'ExpandableText' INSTEAD!
class ExpandableWidget extends StatefulWidget {
  const ExpandableWidget({
    super.key,
    required this.child,
    this.initialLines = 3,
    this.lineHeight = 20,
    this.expandIncrement = 100,
  });
  final Widget child;
  final int initialLines; // number of lines to show initially
  final double
  lineHeight; // approximate line height to calculate initial height
  final double expandIncrement;

  @override
  State<ExpandableWidget> createState() => _ExpandableWidgetState();
}

class _ExpandableWidgetState extends State<ExpandableWidget> {
  double? _height;
  bool _isOverflowing = false;
  final GlobalKey _childKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => _checkOverflow());
  }

  void _checkOverflow() {
    final context = _childKey.currentContext;
    if (context == null) return;

    final renderBox = context.findRenderObject() as RenderBox;
    final childHeight = renderBox.size.height;

    setState(() {
      final initialHeight = widget.initialLines * widget.lineHeight;
      _isOverflowing = childHeight > initialHeight;
      _height ??= initialHeight;
    });
  }

  void _viewMorePressed() {
    setState(() {
      _height = (_height ?? 0) + widget.expandIncrement;
    });
    WidgetsBinding.instance.addPostFrameCallback((_) => _checkOverflow());
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          curve: Curves.fastOutSlowIn,
          height: _height,
          child: ClipRect(
            child: OverflowBox(
              alignment: Alignment.topLeft,
              minHeight: 0,
              maxHeight: double.infinity,
              child: KeyedSubtree(key: _childKey, child: widget.child),
            ),
          ),
        ),
        if (_isOverflowing)
          GestureDetector(
            onTap: _viewMorePressed,
            child: Text(
              "View more",
              style: Theme.of(context).textTheme.bodySmall,
            ),
          ),
      ],
    );
  }
}
