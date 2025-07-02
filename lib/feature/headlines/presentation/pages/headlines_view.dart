import 'package:auto_route/annotations.dart';
import 'package:auto_route/auto_route.dart';
import 'package:dailypulsenews/core/core.dart';
import 'package:dailypulsenews/feature/auth/application/bloc/auth_bloc.dart';
import 'package:dailypulsenews/feature/headlines/application/bloc/news_bloc.dart';
import 'package:dailypulsenews/feature/headlines/presentation/widgets/headline_card.dart';
import 'package:dailypulsenews/gen/assets.gen.dart';
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
      drawer: Drawer(
        child: ListView(
          children: [
            BlocListener<AuthBloc, AuthState>(
              listener: (context, state) {
                if (state.status == AuthStatus.logout) {
                  context.router.replace(UserRegistrationRoute());
                }
              },
              child: DrawerHeader(
                decoration: BoxDecoration(color: Colors.grey.shade300),
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
            ListTile(
              leading: const Icon(Icons.exit_to_app),
              title: Text(context.loc.logout),
              onTap: () => context.read<AuthBloc>().add(SignOut()),
            )
          ],
        ),
      ),
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
