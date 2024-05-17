import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:json_theme/json_theme.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/providers/account_model.dart';
import 'package:todo_app/providers/mission_model.dart';
import 'package:todo_app/providers/missions_model.dart';
import 'package:todo_app/views/create_task/create_task.dart';
import 'package:todo_app/views/create_task/create_task_details.dart';
import 'package:todo_app/views/home/home.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final themeStr = await rootBundle.loadString('assets/appainter_theme.json');
  final themeJson = jsonDecode(themeStr);
  final theme = ThemeDecoder.decodeThemeData(themeJson)!;

  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (context) => AccountModel()),
    ChangeNotifierProvider(create: (context) => MissionModel()),
    ChangeNotifierProvider(create: (context) => MissionsModel()),
  ], child: MyApp(theme: theme.copyWith())));
}

final GoRouter _router = GoRouter(
  routes: <RouteBase>[
    GoRoute(
      name: 'home',
      path: '/',
      builder: (BuildContext context, GoRouterState state) {
        return const Home();
      },
      routes: <RouteBase>[
        GoRoute(
          name: 'create-task',
          path: 'create-task',
          builder: (BuildContext context, GoRouterState state) {
            return const CreateTask();
          },
        ),
        GoRoute(
          name: 'create-task-details',
          path: 'create-task/details',
          builder: (BuildContext context, GoRouterState state) {
            return const CreateTaskDetails();
          },
        ),
        GoRoute(
          name: 'task-details',
          path: 'task',
          builder: (BuildContext context, GoRouterState state) {
            return const CreateTaskDetails();
          },
        ),
      ],
    ),
  ],
);

class MyApp extends StatelessWidget {
  /// Constructs a [MyApp]
  const MyApp({super.key, required this.theme});

  final ThemeData theme;

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      theme: theme,
      routerConfig: _router,
    );
  }
}
