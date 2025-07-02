import 'package:dailypulsenews/core/core.dart';
import 'package:dailypulsenews/feature/headlines/data/models/article_model.dart';
import 'package:flutter/material.dart';

class SourceAuthorHeader extends StatelessWidget {
  final Article article;

  const SourceAuthorHeader({super.key, required this.article});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CircleAvatar(
          backgroundColor: context.colorScheme.primary,
          child: Icon(Icons.newspaper),
        ),
        const SizedBox(width: 10),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              article.source.name,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            if (article.author != null) ...[
              Text(
                article.author.toString(),
                style: TextStyle(color: Colors.grey.shade600),
              ),
            ]
          ],
        ),
      ],
    );
  }
}
