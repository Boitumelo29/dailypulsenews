import 'package:dailypulsenews/core/core.dart';
import 'package:dailypulsenews/feature/auth/application/bloc/auth_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppProvider extends StatelessWidget {
  final Widget child;

  const AppProvider({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(providers: [
      BlocProvider(
          create: (context) => getIt<AuthBloc>()..add(CheckAuthStatus()))
    ], child: child);
  }
}
