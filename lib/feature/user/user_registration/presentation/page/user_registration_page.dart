import 'package:auto_route/annotations.dart';
import 'package:auto_route/auto_route.dart';
import 'package:dailypulsenews/core/dependency_injection/di.dart';
import 'package:dailypulsenews/feature/user/user_registration/application/bloc/user_registration_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

@RoutePage()
class UserRegistrationWrapperPage extends StatelessWidget {
  const UserRegistrationWrapperPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<UserRegistrationBloc>(),
      child: AutoRouter(),
    );
  }
}
