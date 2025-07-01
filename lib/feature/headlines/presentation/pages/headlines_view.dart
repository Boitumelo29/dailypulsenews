import 'package:dailypulsenews/core/extenstions/localization_extensions.dart';
import 'package:dailypulsenews/feature/headlines/application/bloc/news_bloc.dart';
import 'package:dailypulsenews/feature/headlines/presentation/widgets/headline_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(context.loc.dailyPulseNews),
        ),
        body: BlocConsumer<NewsBloc, NewsState>(
          listener: _listener,
          builder: (context, state) {
            if (state.loading) {
              return const Center(child: CircularProgressIndicator());
            }

            return ListView.builder(
              itemCount: state.articles.length,
              itemBuilder: (context, index) {
                final article = state.articles[index];
                return HeadlineCard(article: article);
              },
            );
          },
        ));
  }

  void _listener(BuildContext context, NewsState state) {
    state.articlesEitherFailureOrUnit.fold(
      () => null,
      (either) => either.fold(
        (failure) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(failure.message)),
          );
        },
        (_) {},
      ),
    );
  }
}
