import 'package:auto_route/annotations.dart';
import 'package:auto_route/auto_route.dart';
import 'package:dailypulsenews/core/core.dart';
import 'package:dailypulsenews/feature/headlines/headlines.dart';
import 'package:dailypulsenews/feature/headlines/presentation/widgets/bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

@RoutePage()
class HeadlinesView extends StatefulWidget {
  const HeadlinesView({super.key});

  @override
  State<HeadlinesView> createState() => _HeadlinesViewState();
}

class _HeadlinesViewState extends State<HeadlinesView> {
  final List<Map<String, String>> countries = const [
    {'name': 'United States', 'code': 'US'},
    {'name': 'Canada', 'code': 'CA'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: UserDrawer(),
      appBar: AppBar(
        title: Text(context.loc.dailyPulseNews),
      ),
      body: RefreshIndicator(
        displacement: 40,
        edgeOffset: 8,
        onRefresh: () async {
          final selected = context.read<NewsBloc>().state.selectedCountry;
          context.read<NewsBloc>().add(
                NewsEvent.fetchHeadlines(country: selected),
              );
        },
        child: BlocConsumer<NewsBloc, NewsState>(
          listener: _listener,
          builder: (context, state) {
            if (state.loading) {
              return const Center(child: CircularProgressIndicator());
            }

            if (state.articles.isEmpty) {
              return Center(
                  child: Text(
                context.loc.noNewNews,
                style: context.textTheme.bodyLarge,
              ));
            }

            return ListView.builder(
              itemCount: state.articles.length,
              itemBuilder: (context, index) {
                final article = state.articles[index];
                return HeadlineCard(article: article);
              },
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showCountryListBottomSheet(context, countries);
        },
        child: Icon(
          Icons.change_circle,
          color: context.colorScheme.onSurface,
        ),
      ),
    );
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
