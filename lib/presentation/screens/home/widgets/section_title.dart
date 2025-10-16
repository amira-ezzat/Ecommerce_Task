import 'package:flutter/material.dart';
import '../../../../core/styles/app_texts.dart';

class SectionTitle extends StatelessWidget {
  final String title;

  const SectionTitle({
    super.key,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: AppTexts(data: title).SemiBold20(context),
    );
  }
}
