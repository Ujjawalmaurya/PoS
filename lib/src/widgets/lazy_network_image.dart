import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:pos/src/widgets/pos_loading.dart';

class NetworkImageLoader extends StatelessWidget {
  const NetworkImageLoader({
    super.key,
    required this.image,
    this.height = 50,
    this.width = 50,
  });

  final String image;
  final double height;
  final double width;

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      fit: BoxFit.fill,
      // placeholder: (c, s) => Text(s),
      imageUrl: image,
      height: height,
      width: width,
      placeholder: (context, url) => const Center(child: ShowLoading()),
      errorWidget: (context, url, error) => const Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(Icons.broken_image),
          Text("Error"),
        ],
      ),
    );
  }
}
