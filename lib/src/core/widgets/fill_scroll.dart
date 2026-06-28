import 'package:flutter/widgets.dart';

class FillSpaceScroll extends StatelessWidget {
  const FillSpaceScroll({
    super.key,
    required this.children,
    this.mainAxisAlignment = MainAxisAlignment.center,
    this.crossAxisAlignment = CrossAxisAlignment.center,
    this.padding,
    this.physics = const BouncingScrollPhysics(),
    this.maxWidth,
  });
  final List<Widget> children;
  final MainAxisAlignment mainAxisAlignment;
  final CrossAxisAlignment crossAxisAlignment;
  final EdgeInsetsGeometry? padding;
  final ScrollPhysics physics;
  final double? maxWidth;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final resolvedPadding = padding ?? EdgeInsets.zero;
        final paddingHeight = resolvedPadding.vertical;

        return ListView(
          physics: physics,
          padding: resolvedPadding,
          children: [
            Center(
              child: Padding(
                padding: const EdgeInsets.only(right: 0),
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    minHeight: constraints.maxHeight - paddingHeight,
                    maxWidth: maxWidth ?? double.maxFinite,
                  ),
                  child: Column(
                    mainAxisAlignment: mainAxisAlignment,
                    crossAxisAlignment: crossAxisAlignment,
                    children: children,
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
