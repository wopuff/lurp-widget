import 'package:flutter/material.dart';
import 'package:lurp/src/core/widgets/smart_text.dart';
import 'package:lurp/src/domain/entities/thought.dart';

class ThoughtWidget extends StatelessWidget {
  final ThoughtPost thought;

  const ThoughtWidget({super.key, required this.thought});

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints(minHeight: 70),
      alignment: Alignment.centerLeft,
      padding: const EdgeInsets.symmetric(horizontal: 12.5, vertical: 10),
      decoration: BoxDecoration(
        border: Border.all(
          color: Theme.of(context).colorScheme.secondary,
          width: 3,
        ),
        borderRadius: BorderRadius.circular(12.5),
      ),
      child: SmartText(text: thought.text),
    );
  }
}
