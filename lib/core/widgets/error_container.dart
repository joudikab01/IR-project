import 'package:flutter/material.dart';

class ErrorContainer extends StatelessWidget {
  final String errorMsg;
  final Function onTap;
  final Widget? suffix;

  const ErrorContainer({
    super.key,
    required this.errorMsg,
    required this.onTap,
    this.suffix,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        onTap();
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.transparent,
          border: Border.all(
            color: Theme.of(context).colorScheme.error,
          ),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          children: [
            Expanded(
              child: Text(
                errorMsg,
                style: Theme.of(context).textTheme.labelMedium,
              ),
            ),
            if (suffix != null)
              Padding(
                padding: const EdgeInsets.only(right: 8),
                child: suffix!,
              ),
          ],
        ),
      ),
    );
  }
}
