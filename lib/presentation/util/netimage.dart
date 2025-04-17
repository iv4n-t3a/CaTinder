import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

class NetImage extends StatelessWidget {
  final String url;
  final int height = 500;

  const NetImage({
    super.key,
    required this.url,
  });

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: url,
      height: 500,
      width: double.infinity,
      fit: BoxFit.cover,
      placeholder: (context, url) =>
          const Center(child: CircularProgressIndicator()),
    );
  }
}
