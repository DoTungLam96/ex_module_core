import 'package:flutter/material.dart';

class NavigationService {
  final navigatorKey = GlobalKey<NavigatorState>();
  BuildContext get navigatorContext => navigatorKey.currentState!.context;
}
