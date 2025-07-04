import 'package:auto_route/auto_route.dart';
import 'package:dailypulsenews/core/dependency_injection/di.dart';
import 'package:dailypulsenews/feature/headlines/application/bloc/news_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

@RoutePage()
class HeadlinesWrapperPage extends StatelessWidget {
  const HeadlinesWrapperPage({super.key});

  @override
  Widget build(BuildContext context) {
    final newsBloc = getIt<NewsBloc>();
    return BlocProvider(
      create: (context) => newsBloc..add(const LoadPreferredCountry()),
      child: AutoRouter(),
    );
  }
}
