/*import 'package:flutter/material.dart';

import 'package:lurp/core/utils/color_utils.dart';
import 'package:lurp/core/widgets/background_blur.dart';

final selectedIndexProvider = StateProvider<int>((ref) => 0);
final menuOpenProvider = StateProvider<bool>((ref) => false);
final menuItemsProvider = StateProvider<List<PopupMenuItemContent>>(
  (ref) => [
    PopupMenuItemContent(
      text: 'Latest',
      icon: const Icon(
        Icons.timelapse,
      ),
    ),
    PopupMenuItemContent(
      text: 'Oldest',
      icon: const Icon(
        Icons.timelapse,
      ),
    ),
    PopupMenuItemContent(
      text: 'Popular',
      icon: const Icon(
        Icons.person,
      ),
    ),
  ],
);

class PopupSelectionMenu extends ConsumerWidget {
  // final List<PopupMenuItemContent> content;
  final void Function(String) onClose;

  const PopupSelectionMenu({
    super.key,
    // required this.content,
    required this.onClose,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedIndex = ref.watch(selectedIndexProvider);
    final selectedIndexNotifier = ref.read(selectedIndexProvider.notifier);
    final isOpen = ref.watch(menuOpenProvider);
    final isOpenNotifier = ref.read(menuOpenProvider.notifier);
    final content = ref.watch(menuItemsProvider);

    return BackgroundBlur(
      child: SizedBox(
        width: 120,
        height: null,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            for (int i = 0; i < content.length; i++)
              if (isOpen || i == selectedIndex)
                PopupMenuItem(
                  item: content[i],
                  onPressed: () {
                    if (isOpen) {
                      selectedIndexNotifier.state = i;
                      onClose(content[i].text.toLowerCase());
                    } else {
                      // put selected index first in list
                      var selectedItem = content[selectedIndex];
                      content.removeAt(selectedIndex);
                      content.insert(0, selectedItem);
                      selectedIndexNotifier.state = 0;
                    }
                    isOpenNotifier.state = !isOpen;
                  },
                  isOpen: isOpen,
                ),
          ],
        ),
      ),
    );
  }
}

class PopupMenuItem extends StatelessWidget {
  final PopupMenuItemContent item;
  final VoidCallback onPressed;
  final bool isOpen;

  const PopupMenuItem({
    super.key,
    required this.item,
    required this.onPressed,
    required this.isOpen,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () => onPressed(),
      style: ElevatedButton.styleFrom(
        backgroundColor: Theme.of(context).colorScheme.onSurface.dim(0.07),
        surfaceTintColor: Theme.of(context).colorScheme.onSurface,
        foregroundColor: Theme.of(context).colorScheme.onSurface,
        fixedSize: const Size.fromHeight(45),
        shape: const RoundedRectangleBorder(borderRadius: BorderRadius.zero),
        padding: const EdgeInsets.symmetric(horizontal: 15),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            item.text,
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          const Spacer(),
          if (isOpen) item.icon,
          if (!isOpen) const Icon(Icons.arrow_drop_down),
        ],
      ),
    );
  }
}

class PopupMenuItemContent {
  final String text;
  final Widget icon;

  PopupMenuItemContent({
    required this.text,
    required this.icon,
  });
}
*/
