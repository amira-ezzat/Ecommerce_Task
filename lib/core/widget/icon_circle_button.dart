import 'package:flutter/material.dart';

class IconCircleButton extends StatelessWidget {
  final IconData? icon;
  final Widget? iconWidget;
  final VoidCallback onPressed;
  final double size;
  final Color borderColor;

  const IconCircleButton({
    super.key,
    this.icon,
    this.iconWidget,
    required this.onPressed,
    this.size = 48,
    required this.borderColor,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      borderRadius: BorderRadius.circular(size / 2),
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          border: Border.all(color: borderColor, width: 1),
          shape: BoxShape.circle,
        ),
        child: Center(
          child: iconWidget ??
              Icon(
                icon,
                size: 24,
                color: Theme.of(context).iconTheme.color,
              ),
        ),
      ),
    );
  }
}
