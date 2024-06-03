import 'package:flutter/material.dart';

import 'app_button.dart';

class AppError extends StatelessWidget {
  final String msg;
  final Function() retry;
  final Color color;

  const AppError({
    super.key,
    required this.msg,
    required this.retry,
    this.color = Colors.black,
  });

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints(
        minHeight: MediaQuery.of(context).size.height / 2,
        maxHeight: MediaQuery.of(context).size.height / 1.2,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            msg,
            style: Theme.of(context).textTheme.titleLarge,
            textAlign: TextAlign.center,
          ),
          const SizedBox(
            height: 40,
          ),
          AppButton(
            text: "retry",
            color: color,
            textColor: Colors.white,
            action: retry,
            customWidth: 120,
          )
        ],
      ),
    );
  }
}
