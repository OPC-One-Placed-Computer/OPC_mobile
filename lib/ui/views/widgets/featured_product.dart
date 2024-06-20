import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class FeaaturedProduct extends StatelessWidget {
  const FeaaturedProduct({super.key, required this.image});

  final String image;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 440.0,
      margin: const EdgeInsets.all(20.0),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8.0),
        child: CachedNetworkImage(
          imageUrl: "http://via.placeholder.com/350x150",
          placeholder: (context, url) => CircularProgressIndicator(),
          errorWidget: (context, url, error) => Icon(Icons.error),
        ),
      ),
    );
  }
}
