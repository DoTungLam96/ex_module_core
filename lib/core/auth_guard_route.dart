// import 'package:flutter/material.dart';
// import 'package:iboard_core/iboard_core.dart';

// typedef Route<dynamic> GenerateRoute(RouteSettings settings);

// Route<dynamic> authenticateGuardRoute(Route nextRoute, RouteSettings settings,
//     [GenerateRoute? onGenerateRoute]) {
//   final AuthCubit cubit = GetIt.instance.get<AuthCubit>();
//   if (cubit.state.user == null) {
//     return ModuleManagement().onGenerateRoute(RouteSettings(
//       name: './login?successful=${settings.name}',
//       arguments: settings.arguments,
//     ));
//   } else {
//     return nextRoute;
//   }
// }

// Route<dynamic> getAuthenticateGuardRoute(
//     Widget widget, RouteSettings settings) {
//   return authenticateGuardRoute(getPageRoute(widget, settings), settings);
// }

// Route<dynamic> getPageRoute(Widget widget, RouteSettings settings) {
//   return MaterialPageRoute(builder: (_) => widget, settings: settings);
// }
