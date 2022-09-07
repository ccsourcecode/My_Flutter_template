import 'package:flutter/material.dart';

import 'colors.dart';
import 'dimens.dart';

class TextStyles {
  static const tapText = TextStyle(
    fontSize: 80.0,
    color: Colours.oil1Color,
    fontWeight: FontWeight.bold,
  );

  static const TextStyle textSize12 = TextStyle(
    fontSize: Dimens.font_p12,
  );

  static const TextStyle textSize16 = TextStyle(
    fontSize: Dimens.font_p16,
  );

  static const TextStyle textBold14 =
      TextStyle(fontSize: Dimens.font_p14, fontWeight: FontWeight.bold);

  static const TextStyle textBold16 =
      TextStyle(fontSize: Dimens.font_p16, fontWeight: FontWeight.bold);

  static const TextStyle textBold18 =
      TextStyle(fontSize: Dimens.font_p18, fontWeight: FontWeight.bold);

  static const TextStyle textBold24 =
      TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold);

  static const TextStyle textBold26 =
      TextStyle(fontSize: 26.0, fontWeight: FontWeight.bold);

  static const TextStyle textGray14 = TextStyle(
    fontSize: Dimens.font_p14,
    color: Colours.text_gray,
  );

  static const TextStyle textDarkGray14 = TextStyle(
    fontSize: Dimens.font_p14,
    color: Colours.dark_text_gray,
  );

  static const TextStyle textWhite14 = TextStyle(
    fontSize: Dimens.font_p14,
    color: Colors.white,
  );

  static const TextStyle text = TextStyle(
      fontSize: Dimens.font_p14,
      color: Colours.text,
      // https://github.com/flutter/flutter/issues/40248
      textBaseline: TextBaseline.alphabetic);

  static const TextStyle textDark = TextStyle(
      fontSize: Dimens.font_p14,
      color: Colours.dark_text,
      textBaseline: TextBaseline.alphabetic);

  static const TextStyle textGray12 = TextStyle(
      fontSize: Dimens.font_p12,
      color: Colours.text_gray,
      fontWeight: FontWeight.normal);

  static const TextStyle textDarkGray12 = TextStyle(
      fontSize: Dimens.font_p12,
      color: Colours.dark_text_gray,
      fontWeight: FontWeight.normal);

  static const TextStyle textHint14 = TextStyle(
      fontSize: Dimens.font_p14, color: Colours.dark_unselected_item_color);
}
