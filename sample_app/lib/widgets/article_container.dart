import 'package:flutter/material.dart';
import 'package:sample_app/models/article.dart';
import 'package:intl/intl.dart';
import 'package:sample_app/screens/article_screen.dart';

class ArticleContainer extends StatelessWidget {
  const ArticleContainer({super.key, required this.article});

  final Article article;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
      child: GestureDetector(
        onTap: () => Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => ArticleScreen(article: article),
        )),
        child: Container(
          padding: const EdgeInsets.fromLTRB(20, 16, 20, 12),
          decoration: const BoxDecoration(
            color: Color(0xFF55C500),
            borderRadius: BorderRadius.all(Radius.circular(32)),
          ),
          height: 184,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Created at
              Text(
                DateFormat('yyyy/MM/dd').format(article.createdAt),
                style: const TextStyle(color: Colors.white, fontSize: 12),
              ),
              // Title
              Text(
                article.title,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              // Tags
              Text(
                '#${article.tags.join(' #')}',
                style: const TextStyle(
                  fontSize: 12,
                  color: Colors.white,
                  fontStyle: FontStyle.italic,
                ),
              ),
              // Likes count and user profile
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Likes count
                  Column(
                    children: [
                      const Icon(
                        Icons.favorite,
                        color: Colors.white,
                      ),
                      Text(
                        article.likesCount.toString(),
                        style:
                            const TextStyle(color: Colors.white, fontSize: 12),
                      )
                    ],
                  ),
                  // User profile
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      CircleAvatar(
                        radius: 26,
                        backgroundImage:
                            NetworkImage(article.user.profileImageUrl),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        article.user.id,
                        style:
                            const TextStyle(color: Colors.white, fontSize: 12),
                      )
                    ],
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
