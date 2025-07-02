import 'package:auto_route/annotations.dart';
import 'package:dailypulsenews/core/core.dart';
import 'package:dailypulsenews/feature/article/presentation/widget/source_author_header.dart';
import 'package:dailypulsenews/feature/headlines/data/models/article_model.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

@RoutePage()
class ArticleDetailPage extends StatelessWidget {
  final Article article;

  const ArticleDetailPage({super.key, required this.article});

  @override
  Widget build(BuildContext context) {
    final formattedDate = DateFormat('jm, MMM d, yyyy')
        .format(DateTime.parse(article.publishedAt));

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 300,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              background: Stack(
                fit: StackFit.expand,
                children: [
                  Image.network(
                    article.urlToImage ?? '',
                    fit: BoxFit.cover,
                    errorBuilder: (_, __, ___) =>
                        Container(color: Colors.grey.shade300),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          Colors.transparent,
                          Colors.black.withValues(alpha: 0.6)
                        ],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Container(
              padding: const EdgeInsets.all(20),
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 12),
                  Text(
                    article.title,
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    context.loc.trending(formattedDate),
                    style: Theme.of(context).textTheme.labelMedium?.copyWith(
                          color: Colors.grey.shade600,
                        ),
                  ),
                  const SizedBox(height: 20),
                  SourceAuthorHeader(article: article),
                  const SizedBox(height: 16),
                  Text(
                    article.content ??
                        article.description ??
                        context.loc.noContent,
                    style: Theme.of(context)
                        .textTheme
                        .bodyMedium
                        ?.copyWith(height: 1.6),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
