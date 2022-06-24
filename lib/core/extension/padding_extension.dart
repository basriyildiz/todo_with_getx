import 'package:flutter/cupertino.dart';

extension PaddingExtension on BuildContext {
  static const double veryLow = 5;
  static const double low = 10;
  static const double normal = 20;
  static const double medium = 30;
  static const double extra = 40;

  //  All edge
  EdgeInsets get allVeryLowPadding => const EdgeInsets.all(veryLow);
  EdgeInsets get allLowPadding => const EdgeInsets.all(low);
  EdgeInsets get allNormalPadding => const EdgeInsets.all(normal);
  EdgeInsets get allMediumPadding => const EdgeInsets.all(medium);
  EdgeInsets get allExtraPadding => const EdgeInsets.all(extra);

  //  Horizontal
  EdgeInsets get horizontalVeryLowPadding =>
      const EdgeInsets.symmetric(horizontal: veryLow);
  EdgeInsets get horizontalLowPadding =>
      const EdgeInsets.symmetric(horizontal: low);
  EdgeInsets get horizontalNormalPadding =>
      const EdgeInsets.symmetric(horizontal: normal);
  EdgeInsets get horizontalMediumPadding =>
      const EdgeInsets.symmetric(horizontal: medium);
  EdgeInsets get horizontalExtraPadding =>
      const EdgeInsets.symmetric(horizontal: extra);

  //  Vertical
  EdgeInsets get verticalVeryLowPadding =>
      const EdgeInsets.symmetric(vertical: veryLow);
  EdgeInsets get verticalLowPadding =>
      const EdgeInsets.symmetric(vertical: low);
  EdgeInsets get verticalNormalPadding =>
      const EdgeInsets.symmetric(vertical: normal);
  EdgeInsets get verticalMediumPadding =>
      const EdgeInsets.symmetric(vertical: medium);
  EdgeInsets get verticalExtraPadding =>
      const EdgeInsets.symmetric(vertical: extra);
}
