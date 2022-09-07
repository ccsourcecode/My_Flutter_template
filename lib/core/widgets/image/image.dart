import '../../flutter_gen/assets.gen.dart';
import 'package:flutter/widgets.dart';

Image profileImage(String? imageUrl) {
  if (imageUrl == null || imageUrl.isEmpty) {
    return Assets.images.iconPlaceholder.image();
  }
  return Image.network(imageUrl);
}

ImageProvider profileImageProvider(String? imageUrl) {
  if (imageUrl == null || imageUrl.isEmpty) {
    return  AssetImage(Assets.images.iconPlaceholder.path);
  }
  return NetworkImage(imageUrl);
}

Image networkImage(String? url, {BoxFit? fit}) {
  final placeholder = Assets.images.articlePlaceholder.image(fit: fit);
  if (url == null || url.isEmpty) {
    return placeholder;
  }
  return Image.network(
    url,
    fit: fit,
    errorBuilder: (context, url, dynamic error) => placeholder,
  );
}
