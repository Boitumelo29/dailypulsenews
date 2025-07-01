import 'package:auto_route/auto_route.dart';
import 'package:dailypulsenews/core/dependency_injection/di.dart';
import 'package:dailypulsenews/feature/headlines/application/bloc/news_bloc.dart';
import 'package:dailypulsenews/feature/headlines/presentation/pages/headlines_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

@RoutePage()
class HeadlinesPage extends StatelessWidget {
  const HeadlinesPage({super.key});

  @override
  Widget build(BuildContext context) {

    final newsBloc = getIt<NewsBloc>()..add(FetchHeadlines(country: 'us'));
    return BlocProvider(
      create: (context) =>newsBloc,
      child: HomeView(),
    );
  }
}
