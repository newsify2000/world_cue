import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:world_cue/core/utils/utilities.dart';
import 'package:world_cue/generated/l10n.dart';

class CustomNetworkImage extends StatelessWidget {
  final double? width;
  final double? height;
  final String imageUrl;
  final BoxFit fit;
  final BorderRadius? borderRadius;

  const CustomNetworkImage({
    super.key,
    required this.imageUrl,
    this.width,
    this.height,
    this.fit = BoxFit.cover,
    this.borderRadius,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: borderRadius ?? BorderRadius.circular(0),
      child: CachedNetworkImage(
        width: width,
        height: height,
        imageUrl: imageUrl,
        fit: fit,
        placeholder: (context, url) => _buildShimmerPlaceholder(),
        errorWidget: (context, url, error) => _buildErrorPlaceholder(context),
      ),
    );
  }

  Widget _buildShimmerPlaceholder() {
    return Shimmer.fromColors(
      baseColor: Colors.grey.shade800,
      highlightColor: Colors.grey.shade700,
      child: Container(
        width: width ?? double.infinity,
        height: height ?? 200,
        decoration: BoxDecoration(
          color: Colors.grey.shade900,
          borderRadius: borderRadius ?? BorderRadius.circular(0),
        ),
      ),
    );
  }

  Widget _buildErrorPlaceholder(BuildContext context) {
    return Container(
      width: width ?? double.infinity,
      height: height ?? 200,
      color: Colors.grey.shade900,
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.error_outline,
              color: appColorScheme(context).error,
              size: 32,
            ),
            const SizedBox(height: 6),
            Text(
              S.of(context).failedToLoadImage,
              style: TextStyle(
                color: appColorScheme(context).onPrimary,
                fontSize: 12,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
