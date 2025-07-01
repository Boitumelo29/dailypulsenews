import 'package:dailypulsenews/core/extenstions/localization_extensions.dart';
import 'package:dailypulsenews/core/extenstions/theme_extensions.dart';
import 'package:flutter/material.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              context.loc.dailyPulseNews,
              style: context.textTheme.headlineLarge
                  ?.copyWith(color: context.colorScheme.primary),
            )
          ],
        ),
      ),
    );
  }
}
