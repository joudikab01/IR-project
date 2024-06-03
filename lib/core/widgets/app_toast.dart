import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:ir/core/style/theme.dart';

import '../utils/toaster.dart';

enum ToastStatus { success, fail, warning }

class AppToast extends StatelessWidget {
  final String title;
  final String message;
  final ToastStatus status;

  const AppToast({
    super.key,
    required this.title,
    required this.message,
    this.status = ToastStatus.success,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 116,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: Theme.of(context).colorScheme.background,
        boxShadow: Theme.of(context).own().elevation3,
      ),
      child: Row(
        children: [
          Container(
            width: 10,
            margin: const EdgeInsetsDirectional.only(
                start: 12, top: 14, bottom: 14, end: 12),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              color: status == ToastStatus.success
                  ? Theme.of(context).colorScheme.secondary
                  : status == ToastStatus.warning
                      ? Theme.of(context).colorScheme.tertiary
                      : Theme.of(context).colorScheme.error,
            ),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 22.0, bottom: 12),
                      child: Text(
                        title,
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                              color: status == ToastStatus.success
                                  ? Theme.of(context).colorScheme.secondary
                                  : status == ToastStatus.warning
                                      ? Theme.of(context).colorScheme.tertiary
                                      : Theme.of(context).colorScheme.error,
                            ),
                      ),
                    ),
                    IconButton(
                      padding: EdgeInsets.zero,
                      onPressed: () {
                        Toaster.hideToast();
                      },
                      icon: const Icon(Icons.close),
                    ),
                  ],
                ),
                AutoSizeText(
                  message,
                  maxLines: 2,
                  style: Theme.of(context).textTheme.titleMedium,
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
