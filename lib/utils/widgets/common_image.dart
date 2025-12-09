import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class CommonImage extends StatelessWidget {
  final String? image;
  final double? height;
  final double? width;

  final double radius;
  final BoxFit fit;
  final ImageType type;

  // NEW
  final Color? borderColor;
  final double borderWidth;
  final bool enableShadow;

  const CommonImage({
    super.key,
    required this.image,
    this.height,
    this.width,
    this.radius = 12,
    this.fit = BoxFit.cover,
    this.type = ImageType.network,
    this.borderColor,
    this.borderWidth = 0,
    this.enableShadow = false,
  });

  @override
  Widget build(BuildContext context) {
    final hasBorder = borderWidth > 0;

    return Container(
      height: height,
      width: width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(radius),
        border: hasBorder
            ? Border.all(
          color: borderColor ?? Colors.grey.shade300,
          width: borderWidth,
        )
            : null,
        boxShadow: enableShadow
            ? [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 10,
            offset: const Offset(0, 4),
          )
        ]
            : null,
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(radius),
        child: _buildImage(),
      ),
    );
  }

  Widget _buildImage() {
    if (image == null || image!.isEmpty) return _placeholder();

    return type == ImageType.asset ? _asset() : _network();
  }

  Widget _network() {
    return CachedNetworkImage(
      imageUrl: image!,
      fit: fit,
      placeholder: (_, __) => _shimmer(),
      errorWidget: (_, __, ___) => _placeholder(),
    );
  }

  Widget _asset() {
    return Image.asset(
      image!,
      fit: fit,
      errorBuilder: (_, __, ___) => _placeholder(),
    );
  }

  Widget _shimmer() {
    return Container(
      color: Colors.grey.shade300,
      child: const Center(
        child: SizedBox(
          height: 24,
          width: 24,
          child: CircularProgressIndicator(strokeWidth: 2),
        ),
      ),
    );
  }

  Widget _placeholder() {
    return Container(
      color: Colors.grey.shade200,
      child: const Center(
        child: Icon(Icons.broken_image, size: 32, color: Colors.grey),
      ),
    );
  }
}

enum ImageType { network, asset }
