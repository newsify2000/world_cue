import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:shimmer/shimmer.dart';

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
    final colorScheme = Theme.of(context).colorScheme;

    return ClipRRect(
      borderRadius: borderRadius ?? BorderRadius.circular(0),
      child: CachedNetworkImage(
        width: width,
        height: height,
        imageUrl: imageUrl,
        fit: fit,
        placeholder: (context, url) => _buildShimmerPlaceholder(),
        errorWidget: (context, url, error) => _buildErrorPlaceholder(colorScheme),
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

  Widget _buildErrorPlaceholder(ColorScheme colorScheme) {
    return Container(
      width: width ?? double.infinity,
      height: height ?? 200,
      color: Colors.grey.shade900,
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.error_outline, color: colorScheme.error, size: 32),
            const SizedBox(height: 6),
            Text(
              "Failed to load image",
              style: TextStyle(
                color: colorScheme.onPrimary,
                fontSize: 12,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
