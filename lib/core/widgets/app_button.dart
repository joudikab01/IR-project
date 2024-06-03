import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class AppButton extends StatelessWidget {
  final String text;
  final ButtonType type;
  final Color? color;
  final Color? textColor;
  final Color? borderColor;
  final bool loading;
  final bool enabled;
  final Color? disabledColor;
  final Color? disabledTextColor;
  final Function action;
  final Widget? leading;
  final Widget? trailing;
  final double? customWidth;
  final double? customHeight;
  final TextStyle? style;
  final double borderRadius;
  final List<BoxShadow>? boxShadow;
  final EdgeInsetsGeometry? margin;

  const AppButton({
    super.key,
    required this.text,
    this.type = ButtonType.primary,
    this.color,
    required this.action,
    this.textColor,
    this.borderColor,
    this.enabled = true,
    this.disabledColor,
    this.disabledTextColor,
    this.loading = false,
    this.leading,
    this.trailing,
    this.customWidth,
    this.customHeight,
    this.style,
    this.borderRadius = 100,
    this.boxShadow,
    this.margin,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (!loading && enabled) {
          action();
        }
      },
      child: AnimatedContainer(
        duration: const Duration(
          milliseconds: 300,
        ),
        width: customWidth,
        height: customHeight ?? 40,
        margin:
            margin ?? const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
        padding: const EdgeInsets.symmetric(horizontal: 24),
        decoration: BoxDecoration(
          border: type.getBorder(context, borderColor, enabled),
          borderRadius: BorderRadius.circular(borderRadius),
          color: color ?? type.getBackGroundColor(context, enabled),
          boxShadow: boxShadow,
        ),
        child: AnimatedSwitcher(
          duration: const Duration(
            milliseconds: 300,
          ),
          transitionBuilder: (Widget child, Animation<double> animation) {
            return FadeTransition(
              opacity: animation,
              child: child,
            );
          },
          child: loading
              ? LoadingAnimationWidget.staggeredDotsWave(
                  size: 30,
                  color: textColor ?? Colors.white,
                )
              : Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    if (leading != null) leading!,
                    if (leading != null)
                      const SizedBox(
                        width: 4,
                      ),
                    Flexible(
                      child: Text(
                        text,
                        style: style?.copyWith(
                              color: textColor ??
                                  (type == ButtonType.bordered
                                      ? Theme.of(context).colorScheme.primary
                                      : type == ButtonType.secondary
                                          ? Theme.of(context)
                                              .colorScheme
                                              .onSecondaryContainer
                                          : Theme.of(context)
                                              .colorScheme
                                              .background),
                            ) ??
                            Theme.of(context).textTheme.titleMedium?.copyWith(
                                  color: textColor ??
                                      (type == ButtonType.bordered
                                          ? Theme.of(context)
                                              .colorScheme
                                              .primary
                                          : type == ButtonType.secondary
                                              ? Theme.of(context)
                                                  .colorScheme
                                                  .onSecondaryContainer
                                              : Theme.of(context)
                                                  .colorScheme
                                                  .background),
                                ),
                        maxLines: 1,
                      ),
                    ),
                    if (trailing != null)
                      const SizedBox(
                        width: 4,
                      ),
                    if (trailing != null) trailing!,
                  ],
                ),
        ),
      ),
    );
  }
}

enum ButtonType {
  primary,
  secondary,
  gradiant,
  disabled,
  bordered,
  white,
  textOnly;

  Border? getBorder(context, Color? color, enabled) {
    if (!enabled) {
      return Border.all(
          width: 1.5, color: Theme.of(context).colorScheme.outline);
    }
    switch (this) {
      case bordered:
        return Border.all(
            width: 1.5, color: color ?? Theme.of(context).colorScheme.outline);
      default:
        return null;
    }
  }

  Color? getBackGroundColor(context, enabled) {
    if (!enabled) {
      return Theme.of(context).colorScheme.outline;
    }
    switch (this) {
      case primary:
        return Theme.of(context).colorScheme.primary;
      case secondary:
        return Theme.of(context).colorScheme.secondaryContainer;
      case textOnly:
        return Colors.transparent;
      case disabled:
        return Theme.of(context).colorScheme.outline;
      case bordered:
      case white:
        return Theme.of(context).colorScheme.background;
      case gradiant:
        return null;
    }
  }
}
