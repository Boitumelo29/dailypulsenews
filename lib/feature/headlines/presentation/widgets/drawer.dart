import 'package:auto_route/auto_route.dart';
import 'package:dailypulsenews/core/core.dart';
import 'package:dailypulsenews/feature/auth/application/bloc/auth_bloc.dart';
import 'package:dailypulsenews/gen/assets.gen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class UserDrawer extends StatelessWidget {
  const UserDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          BlocListener<AuthBloc, AuthState>(
            listener: (context, state) {
              if (state.status == AuthStatus.logout) {
                context.router.replace(UserRegistrationWrapperRoute());
              }
            },
            child: DrawerHeader(
              child: Column(
                children: [
                  Text(
                    context.loc.dailyPulseNews,
                    style: context.textTheme.bodyLarge
                        ?.copyWith(color: context.colorScheme.primary),
                  ),
                  SizedBox(
                    height: 110,
                    width: 110,
                    child: Image.asset(
                      Assets.lib.assets.pulseNewsLogo.path,
                      height: 80,
                      width: 80,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Builder(builder: (context) {
            final user = context.read<AuthBloc>().state.user?.email;

            return ListTile(
              leading: const Icon(Icons.person),
              title: Text(user ?? "Unknown"),
            );
          }),
          ListTile(
            leading: const Icon(Icons.exit_to_app),
            title: Text(context.loc.logout),
            onTap: () => context.read<AuthBloc>().add(SignOut()),
          )
        ],
      ),
    );
  }
}
