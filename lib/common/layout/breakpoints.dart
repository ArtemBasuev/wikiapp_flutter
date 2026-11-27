import 'package:flutter/widgets.dart';

abstract final class Breakpoints {
  static const double expanded = 840;

  static bool isExpanded(BuildContext context) =>
      MediaQuery.sizeOf(context).width >= expanded;
}
