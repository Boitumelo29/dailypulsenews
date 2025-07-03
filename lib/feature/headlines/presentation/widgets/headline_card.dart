import 'package:auto_route/auto_route.dart';
import 'package:dailypulsenews/core/core.dart';
import 'package:dailypulsenews/core/routers/router.dart';
import 'package:dailypulsenews/feature/headlines/data/models/article_model.dart';
import 'package:flutter/material.dart';

class HeadlineCard extends StatelessWidget {
  final Article article;

  const HeadlineCard({super.key, required this.article});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        context.pushRoute(ArticleDetailRoute(article: article));
      },
      child: Card(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: 10,
          children: [
            article.urlToImage != null
                ? Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(8.0),
                      // Adjust the radius as needed
                      child: Image.network(
                        article.urlToImage!,
                        width: 120,
                        height: 120,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) =>
                            const Icon(Icons.image),
                      ),
                    ),
                  )
                : Icon(
                    Icons.newspaper,
                    color: context.colorScheme.primary,
                    size: 30,
                  ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: 10,
                children: [
                  Text(
                    article.title,
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                    style: context.textTheme.headlineSmall,
                  ),
                  Text(article.source.name,
                      style: context.textTheme.bodySmall)
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
