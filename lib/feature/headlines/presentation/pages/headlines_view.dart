import 'package:auto_route/annotations.dart';
import 'package:dailypulsenews/core/core.dart';
import 'package:dailypulsenews/feature/headlines/application/bloc/news_bloc.dart';
import 'package:dailypulsenews/feature/headlines/presentation/widgets/headline_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

@RoutePage()
class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final List<Map<String, String>> countries = const [
    {'name': 'United States', 'code': 'US'},
    {'name': 'Canada', 'code': 'CA'},
  ];

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

          if (state.articles.isEmpty) {
            return Center(child: Text(context.loc.noNewNews));
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
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showCountryListBottomSheet(context);
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

  void _showCountryListBottomSheet(BuildContext context) {
    final selectedCountry = context.read<NewsBloc>().state.selectedCountry;

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (BuildContext context) {
        return SizedBox(
          height: 250,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                     Text(
                      context.loc.selectCountry,
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.close),
                      onPressed: () => Navigator.pop(context),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: countries.length,
                  itemBuilder: (BuildContext context, int index) {
                    final country = countries[index];
                    final isSelected = selectedCountry.toUpperCase() ==
                        country['code']!.toUpperCase();

                    return ListTile(
                      title: Text(
                        country['name']!,
                        style: TextStyle(
                          fontWeight:
                              isSelected ? FontWeight.bold : FontWeight.normal,
                          color: isSelected
                              ? Theme.of(context).colorScheme.primary
                              : null,
                        ),
                      ),
                      trailing: isSelected
                          ? Icon(Icons.check,
                              color: Theme.of(context).colorScheme.primary)
                          : null,
                      onTap: () {
                        final selected = country['code']!;
                        context.read<NewsBloc>().add(
                              NewsEvent.setPreferredCountry(country: selected),
                            );
                        Navigator.pop(context);
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
