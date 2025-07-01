import 'package:dailypulsenews/feature/headlines/data/models/article_model.dart';
import 'package:flutter/material.dart';

class HeadlineCard extends StatelessWidget {
  final Article article;

  const HeadlineCard({super.key, required this.article});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      elevation: 2,
      child: ListTile(
        leading: article.urlToImage != null
            ? Image.network(
                article.urlToImage!,
                width: 60,
                height: 60,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) =>
                    const Icon(Icons.image),
              )
            : const Icon(Icons.image),
        title: Text(
          article.title,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
        subtitle: Text(article.source.name),
        onTap: () {},
      ),
    );
  }
}
