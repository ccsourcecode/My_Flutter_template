/// GENERATED CODE - DO NOT MODIFY BY HAND
/// *****************************************************
///  FlutterGen
/// *****************************************************

// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: directives_ordering,unnecessary_import

import 'package:flutter/widgets.dart';

class $AssetsDataGen {
  const $AssetsDataGen();

  /// File path: assets/data/bank.json
  String get bank => 'assets/data/bank.json';

  /// File path: assets/data/bank_2.json
  String get bank2 => 'assets/data/bank_2.json';

  /// File path: assets/data/city.json
  String get city => 'assets/data/city.json';

  /// File path: assets/data/sort_0.json
  String get sort0 => 'assets/data/sort_0.json';

  /// File path: assets/data/sort_1.json
  String get sort1 => 'assets/data/sort_1.json';

  /// File path: assets/data/sort_2.json
  String get sort2 => 'assets/data/sort_2.json';
}

class $AssetsFontsGen {
  const $AssetsFontsGen();

  /// File path: assets/fonts/Raleway-Italic.ttf
  String get ralewayItalic => 'assets/fonts/Raleway-Italic.ttf';

  /// File path: assets/fonts/Raleway-Regular.ttf
  String get ralewayRegular => 'assets/fonts/Raleway-Regular.ttf';

  /// File path: assets/fonts/Roboto-Thin.ttf
  String get robotoThin => 'assets/fonts/Roboto-Thin.ttf';

  /// File path: assets/fonts/RobotoMono-Bold.ttf
  String get robotoMonoBold => 'assets/fonts/RobotoMono-Bold.ttf';

  /// File path: assets/fonts/RobotoMono-Regular.ttf
  String get robotoMonoRegular => 'assets/fonts/RobotoMono-Regular.ttf';
}

class $AssetsImagesGen {
  const $AssetsImagesGen();

  /// File path: assets/images/app_start_1.webp
  AssetGenImage get appStart1 =>
      const AssetGenImage('assets/images/app_start_1.webp');

  /// File path: assets/images/app_start_2.webp
  AssetGenImage get appStart2 =>
      const AssetGenImage('assets/images/app_start_2.webp');

  /// File path: assets/images/app_start_3.webp
  AssetGenImage get appStart3 =>
      const AssetGenImage('assets/images/app_start_3.webp');

  $AssetsImagesHomeGen get home => const $AssetsImagesHomeGen();

  /// File path: assets/images/ic_arrow_right.png
  AssetGenImage get icArrowRight =>
      const AssetGenImage('assets/images/ic_arrow_right.png');

  /// File path: assets/images/ic_back_black.png
  AssetGenImage get icBackBlack =>
      const AssetGenImage('assets/images/ic_back_black.png');

  /// File path: assets/images/logo.png
  AssetGenImage get logo => const AssetGenImage('assets/images/logo.png');

  /// File path: assets/images/none.png
  AssetGenImage get none => const AssetGenImage('assets/images/none.png');

  /// File path: assets/images/update_head.jpg
  AssetGenImage get updateHead =>
      const AssetGenImage('assets/images/update_head.jpg');
}

class $AssetsLottieGen {
  const $AssetsLottieGen();

  /// File path: assets/lottie/bunny_new_mouth.json
  String get bunnyNewMouth => 'assets/lottie/bunny_new_mouth.json';
}

class $AssetsImagesHomeGen {
  const $AssetsImagesHomeGen();

  /// File path: assets/images/home/icon_commodity.png
  AssetGenImage get iconCommodity =>
      const AssetGenImage('assets/images/home/icon_commodity.png');

  /// File path: assets/images/home/icon_order.png
  AssetGenImage get iconOrder =>
      const AssetGenImage('assets/images/home/icon_order.png');

  /// File path: assets/images/home/icon_shop.png
  AssetGenImage get iconShop =>
      const AssetGenImage('assets/images/home/icon_shop.png');

  /// File path: assets/images/home/icon_statistics.png
  AssetGenImage get iconStatistics =>
      const AssetGenImage('assets/images/home/icon_statistics.png');
}

class Assets {
  Assets._();

  static const $AssetsDataGen data = $AssetsDataGen();
  static const $AssetsFontsGen fonts = $AssetsFontsGen();
  static const $AssetsImagesGen images = $AssetsImagesGen();
  static const $AssetsLottieGen lottie = $AssetsLottieGen();
}

class AssetGenImage {
  const AssetGenImage(this._assetName);

  final String _assetName;

  Image image({
    Key? key,
    AssetBundle? bundle,
    ImageFrameBuilder? frameBuilder,
    ImageErrorWidgetBuilder? errorBuilder,
    String? semanticLabel,
    bool excludeFromSemantics = false,
    double? scale,
    double? width,
    double? height,
    Color? color,
    Animation<double>? opacity,
    BlendMode? colorBlendMode,
    BoxFit? fit,
    AlignmentGeometry alignment = Alignment.center,
    ImageRepeat repeat = ImageRepeat.noRepeat,
    Rect? centerSlice,
    bool matchTextDirection = false,
    bool gaplessPlayback = false,
    bool isAntiAlias = false,
    String? package,
    FilterQuality filterQuality = FilterQuality.low,
    int? cacheWidth,
    int? cacheHeight,
  }) {
    return Image.asset(
      _assetName,
      key: key,
      bundle: bundle,
      frameBuilder: frameBuilder,
      errorBuilder: errorBuilder,
      semanticLabel: semanticLabel,
      excludeFromSemantics: excludeFromSemantics,
      scale: scale,
      width: width,
      height: height,
      color: color,
      opacity: opacity,
      colorBlendMode: colorBlendMode,
      fit: fit,
      alignment: alignment,
      repeat: repeat,
      centerSlice: centerSlice,
      matchTextDirection: matchTextDirection,
      gaplessPlayback: gaplessPlayback,
      isAntiAlias: isAntiAlias,
      package: package,
      filterQuality: filterQuality,
      cacheWidth: cacheWidth,
      cacheHeight: cacheHeight,
    );
  }

  String get path => _assetName;

  String get keyName => _assetName;
}
