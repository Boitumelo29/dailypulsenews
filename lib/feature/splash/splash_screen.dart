import 'package:auto_route/auto_route.dart';
import 'package:dailypulsenews/core/core.dart';
import 'package:dailypulsenews/feature/auth/application/bloc/auth_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

@RoutePage()
class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<AuthBloc>().add(CheckAuthStatus());
    });

    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state.status == AuthStatus.authenticated) {
          context.router.replace(HeadlinesWrapperRoute());
        } else if (state.status == AuthStatus.unauthenticated) {
          context.router.replace(UserRegistrationWrapperRoute());
        }
      },
      child:  Scaffold(
        body: Center(
          child: CircularProgressIndicator(
            color: context.colorScheme.primary,
          ),
        ),
      ),
    );
  }
}
