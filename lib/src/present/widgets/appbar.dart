import 'package:flutter/material.dart';
import 'package:lurp/src/core/widgets/divider.dart';
import 'package:lurp/src/core/utils/layout_utils.dart';

class CustomAppbar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppbar({
    super.key,
    this.title = '',
    this.showCloseButton = true,
    this.onClose,
    this.defaultPageOnClose = 'home',
    this.alwaysShowDivider = false,
    this.neverShowDivider = false,
    this.padding,
  });
  final String title;
  final bool showCloseButton;
  final VoidCallback? onClose;
  final String defaultPageOnClose;
  final bool alwaysShowDivider;
  final bool neverShowDivider;
  final EdgeInsets? padding;

  static Widget titleText(BuildContext context, String text) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Text(
          text,
          textAlign: TextAlign.center,
          overflow: TextOverflow.ellipsis,
          maxLines: 1,
          style: Theme.of(context).textTheme.titleSmall!.copyWith(
            fontSize: 18,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    var extraWidth = LayoutUtils.isMobile(context) ? 0 : 27.5;
    var horizPadding = LayoutUtils.isMobile(context)
        ? LayoutUtils.standardPadding
        : 0.0;

    return Container(
      height: 53,
      padding: padding,
      child: Column(
        children: <Widget>[
          Container(
            constraints: BoxConstraints(
              maxWidth: LayoutUtils.contentMaxWidth(context) + extraWidth,
            ),
            padding: EdgeInsets.fromLTRB(horizPadding, 5, horizPadding, 5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                const SizedBox(width: 40),

                titleText(context, title),

                if (showCloseButton)
                  SizedBox(
                    width: 40,
                    height: 40,
                    child: IconButton(
                      icon: Icon(
                        Icons.close,
                        size: 18,
                        color: Theme.of(
                          context,
                        ).colorScheme.onSurface.withValues(alpha: 0.6),
                      ),
                      onPressed: () => onClose != null
                          ? onClose!()
                          : Navigator.maybePop(context),
                    ),
                  ),
                if (!showCloseButton) const SizedBox.shrink(),
              ],
            ),
          ),
          if ((!neverShowDivider && LayoutUtils.isMobile(context)) ||
              alwaysShowDivider)
            const CustomDivider(),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(50);
}
