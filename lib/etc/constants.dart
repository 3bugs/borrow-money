library constants;

import 'package:libertyfund/etc/utils.dart';
import 'package:flutter/material.dart';

class App {
  static const Color PRIMARY_COLOR = Color(0xFF47A1FD);
  static const Color HEADER_GRADIENT_COLOR_START = Color(0xFF5A6F72);
  static const Color HEADER_GRADIENT_COLOR_END = Color(0xFF242F35);
  static final double HORIZONTAL_MARGIN = getPlatformSize(16.0);
  static final double VERTICAL_MARGIN = getPlatformSize(16.0);
  static final double BOX_BORDER_RADIUS = getPlatformSize(30.0);
}

class LoginScreen {
  static final double LOGO_SIZE = getPlatformSize(150.0);
  static const Color FACEBOOK_BUTTON_BACKGROUND = Color(0xFF465AB1);
  static final double FACEBOOK_ICON_WIDTH = getPlatformSize(20.0);
  static final double FACEBOOK_ICON_HEIGHT = getPlatformSize(FACEBOOK_ICON_WIDTH * 104 / 56);
}