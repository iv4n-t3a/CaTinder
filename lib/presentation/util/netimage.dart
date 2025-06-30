import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

class NetImage extends StatelessWidget {
  final String url;
  final double? height;
  final double? width;

  const NetImage({
    super.key,
    required this.url,
    this.height = double.infinity,
    this.width = double.infinity,
  });

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: url,
      height: height,
      width: width,
      fit: BoxFit.cover,
      placeholder: (context, url) =>
          const Center(child: CircularProgressIndicator()),
      errorWidget: (context, url, error) =>
          const Center(child: Icon(Icons.error, color: Colors.red)),
    );
  }
}
