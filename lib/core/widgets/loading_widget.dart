import 'package:flutter/material.dart';
import 'package:ir/core/widgets/shimmer_widget.dart';
import 'package:shimmer/shimmer.dart';

class LoadingWidget extends StatelessWidget {
  final String error;
  final bool withScrolling;

  const LoadingWidget({super.key, this.error = '', this.withScrolling = true});
  @override
  Widget build(BuildContext context) {
    if (!withScrolling) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }
    return Stack(
      alignment: Alignment.center,
      children: [
        const Center(
          child: CircularProgressIndicator(),
        ),
        SingleChildScrollView(
          child: SizedBox(
            height: MediaQuery.sizeOf(context).height / 1.4,
            width: MediaQuery.sizeOf(context).width,
          ),
        ),
      ],
    );
  }
}
