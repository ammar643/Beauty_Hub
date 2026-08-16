import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:project_user/constant/imageAssets.dart';

class ImageHelper {
  static const String userAgent =
      'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/120.0.0.0 Safari/537.36';

  // For simple Image.network with headers
  static Widget networkImage(
    String url, {
    double? width,
    double? height,
    BoxFit fit = BoxFit.cover,
  }) {
    return Image.network(
      url,
      headers: {'User-Agent': userAgent},
      width: width,
      height: height,
      fit: fit,
      errorBuilder: (context, error, stackTrace) {
        return Image.asset(
          ImageAssets.onbording3,
          width: width,
          height: height,
          fit: fit,
        );
      },
      loadingBuilder: (context, child, loadingProgress) {
        if (loadingProgress == null) return child;
        return Container(
          color: Colors.grey[200],
          child: const Center(child: CircularProgressIndicator()),
        );
      },
    );
  }

  // For CachedNetworkImage (better performance)
  static Widget cachedImage(
    String url, {
    double? width,
    double? height,
    BoxFit fit = BoxFit.cover,
  }) {
    return CachedNetworkImage(
      imageUrl: url,
      httpHeaders: {'User-Agent': userAgent},
      width: width,
      height: height,
      fit: fit,
      placeholder: (context, url) => Container(
        color: Colors.grey[200],
        child: const Center(child: CircularProgressIndicator()),
      ),
      errorWidget: (context, url, error) => Image.asset(
        ImageAssets.onbording3,
        width: width,
        height: height,
        fit: fit,
      ),
    );
  }

  // For CircleAvatar background
  static ImageProvider getImageProvider(String url) {
    if (url.isEmpty) {
      return  AssetImage(ImageAssets.testphoto) as ImageProvider;
    }
    return CachedNetworkImageProvider(
      url,
      headers: {'User-Agent': userAgent},
    );
  }
}