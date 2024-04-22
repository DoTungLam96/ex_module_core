// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:get_it/get_it.dart';
// import 'package:iboard_core/base/app_services.dart';
// import 'package:iboard_core/base/base_module.dart';
// import 'package:iboard_core/base/module_management.dart';
// import 'package:iboard_core/base/utils/pair.dart';
// import 'package:iboard_core/cubit/auth_cubit.dart';

// class AppLauncherProps {
//   AppLauncherProps(
//     this.appName,
//     this.module,
//     this.root,
//     this.debugWidget, {
//     this.arguments,
//     this.callback,
//   });

//   final String appName;
//   final BaseModule module;
//   final String root;
//   final Widget? debugWidget;
//   final dynamic arguments;
//   final Function(BuildContext context)? callback;
// }

// class AppLauncher extends StatefulWidget {
//   const AppLauncher({Key? key, required this.props}) : super(key: key);
//   final AppLauncherProps props;

//   @override
//   // ignore: library_private_types_in_public_api
//   _AppLauncherState createState() =>
//       // ignore: no_logic_in_create_state
//       _AppLauncherState(props);
// }

// class _AppLauncherState extends State<AppLauncher> {
//   _AppLauncherState(this.props);

//   final AppLauncherProps props;

//   @override
//   void initState() {
//     super.initState();
//     if (mounted && props.debugWidget != null) {
//       // ShakeDetector.autoStart(
//       //   onPhoneShake: () {
//       //     final debugWidget = Center(child: props.debugWidget);
//       //     Navigator.push(
//       //         context,
//       //         MaterialPageRoute(
//       //             builder: (_) => Scaffold(body: Center(child: debugWidget))));
//       //   },
//       //   minimumShakeCount: 1,
//       //   shakeSlopTimeMS: 500,
//       //   shakeCountResetTime: 3000,
//       //   shakeThresholdGravity: 2.7,
//       // );
//     }
//   }

//   @override
//   void dispose() {
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(props.appName),
//         backgroundColor: const Color.fromARGB(255, 222, 104, 14),
//       ),
//       backgroundColor: Colors.lightBlue[50],
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: <Widget>[
//             InkWell(
//               onTap: () {
//                 Navigator.pushNamed(
//                   context,
//                   props.root,
//                   arguments: props.arguments,
//                 );
//                 props.callback?.call(context);
//               },
//               child: Container(
//                   color: const Color.fromARGB(255, 222, 104, 14),
//                   width: 110,
//                   height: 45,
//                   child: const Center(
//                       child: Text(
//                     'Start App',
//                     textScaleFactor: 1,
//                     style: TextStyle(
//                         fontWeight: FontWeight.bold, color: Colors.white70),
//                   ))),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// class MiniApp extends StatelessWidget {
//   const MiniApp({Key? key, required this.props}) : super(key: key);
//   final AppLauncherProps props;

//   @override
//   Widget build(BuildContext context) {
//     return MultiBlocProvider(
//       providers: [
//         BlocProvider.value(value: GetIt.instance<AppCubit>()),
//         BlocProvider.value(value: GetIt.instance<AuthCubit>()),
//       ],
//       child: BlocBuilder<AppCubit,
//           AppState<AppTheme, AppLanguage>>(
//         builder: (BuildContext ctx, AppState<AppTheme, AppLanguage> state) {
//           final Locale locale = Locale(state.appLanguage.name);
//           return MaterialApp(
//             title: 'MiniApp',
//             // theme: state.appTheme.data,
//             home: AppLauncher(
//               props: props,
//             ),
//             onGenerateRoute: ModuleManagement().onGenerateRoute,
//             localizationsDelegates: ModuleManagement().localizationsDelegates(),
//             supportedLocales: const [
//               Locale('en', ''),
//               Locale('vi', ''), // English, no country code
//             ],
//             locale: locale,
//           );
//         },
//       ),
//     );
//   }
// }

// class ExampleApp extends StatelessWidget {
//   const ExampleApp({Key? key, required this.screen}) : super(key: key);
//   final Widget screen;

//   @override
//   Widget build(BuildContext context) {
//     return MultiBlocProvider(
//       providers: [
//         BlocProvider.value(value: GetIt.instance<AppCubit>()),
//         BlocProvider.value(value: GetIt.instance<AuthCubit>()..initAuth()),
//       ],
//       child: BlocBuilder<AppCubit, AppState<AppTheme, AppLanguage>>(
//         builder: (BuildContext ctx, AppState<AppTheme, AppLanguage> state) {
//           final Locale locale = Locale(state.appLanguage.name);
//           return MaterialApp(
//             title: 'MiniApp',
//             // theme: state.appTheme.data,
//             home: screen,
//             onGenerateRoute: ModuleManagement().onGenerateRoute,
//             localizationsDelegates: ModuleManagement().localizationsDelegates(),
//             supportedLocales: const [
//               Locale('en', ''),
//               Locale('vi', ''), //// English, no country code
//             ],
//             locale: locale,
//           );
//         },
//       ),
//     );
//   }
// }
