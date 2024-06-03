import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ir/core/widgets/shimmer_widget.dart';

class AppImage extends StatelessWidget {
  final String path;
  final ImageType type;
  final BoxFit fit;
  final Widget errorWidget;
  final Widget? loadingWidget;
  final double borderRadius;
  final Border? border;
  final double? height;
  final double? width;
  final Color? backgroundColor;
  final EdgeInsets? margin;
  final List<BoxShadow>? shadow;
  final ColorFilter? color;

  const AppImage({
    super.key,
    required this.path,
    required this.type,
    this.fit = BoxFit.cover,
    this.errorWidget = const Icon(Icons.error_outline),
    this.borderRadius = 0,
    this.loadingWidget,
    this.height,
    this.width,
    this.shadow,
    this.backgroundColor,
    this.margin,
    this.border,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    Widget defaultLoading = ShimmerWidget.card(
      height: height,
      width: width,
      borderRadius: borderRadius,
    );
    return Container(
      height: height,
      width: width,
      margin: margin,
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(borderRadius),
        boxShadow: shadow,
        border: border,
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(borderRadius),
        child: Builder(
          builder: (context) {
            switch (type) {
              case ImageType.cachedNetwork:
              case ImageType.network:
                return CachedNetworkImage(
                  imageUrl: path,
                  fit: fit,
                  progressIndicatorBuilder: (context, url, downloadProgress) =>
                      loadingWidget ?? defaultLoading,
                  errorWidget: (context, _, i) => errorWidget,
                );
              case ImageType.asset:
                return Image.asset(
                  path,
                  width: width,
                  height: height,
                  errorBuilder: (context, _, i) => errorWidget,
                  fit: fit,
                );
              case ImageType.file:
                return Image.file(
                  File(path),
                  fit: fit,
                  errorBuilder: (context, _, i) => errorWidget,
                );
              case ImageType.svg:
                return SvgPicture.asset(
                  path,
                  fit: fit,
                  colorFilter: color,
                );
              default:
                return const SizedBox();
            }
          },
        ),
      ),
    );
  }
}

enum ImageType { network, file, cachedNetwork, asset, svg }
