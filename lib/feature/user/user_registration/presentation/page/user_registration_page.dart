import 'package:auto_route/annotations.dart';
import 'package:dailypulsenews/feature/user/user_registration/application/bloc/user_registration_bloc.dart';
import 'package:dailypulsenews/feature/user/user_registration/presentation/page/user_registration_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

@RoutePage()
class UserRegistrationPage extends StatelessWidget {
  const UserRegistrationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => UserRegistrationBloc(),
      child: const UserRegistrationView(),
    );
  }
}
