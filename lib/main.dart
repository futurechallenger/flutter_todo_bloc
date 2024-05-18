import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_todo_bloc/bloc/home_bloc.dart';
import 'package:flutter_todo_bloc/bloc/todo_detail_cubit.dart';
import 'package:flutter_todo_bloc/pages/edit_page.dart';
import 'package:flutter_todo_bloc/pages/home_page.dart';
import 'package:flutter_todo_bloc/pages/settings_page.dart';
import 'package:go_router/go_router.dart';

void main() {
  runApp(MultiBlocProvider(providers: [
    BlocProvider<TodoListBloc>(
        create: (BuildContext context) =>
            TodoListBloc()..add(TodoListRequested())),
    BlocProvider<TodoDetailCubit>(create: (_) => TodoDetailCubit()),
  ], child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      // home: const HomePage(),
      routerConfig: GoRouter(routes: [
        GoRoute(path: "/", builder: (_, __) => const HomePage()),
        GoRoute(path: "/edit", builder: (_, __) => const EditPage()),
        GoRoute(path: "/settings", builder: (_, __) => const SettingsPage()),
      ]),
    );
  }
}
