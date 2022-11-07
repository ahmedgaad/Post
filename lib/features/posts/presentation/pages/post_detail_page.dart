import 'package:flutter/material.dart';
import 'package:posts_app/features/posts/domain/entities/posts.dart';

import '../widgets/post_detail_page/post_detail_widget.dart';

class PostDetailPage extends StatelessWidget {
  final Post post;

  const PostDetailPage({Key? key, required this.post}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Post Details'),
      ),
      body:  Center(
        child: Padding(
            padding: const EdgeInsets.all(10.0),
          child: PostDetailWidget(post : post),
        ),
      ),
    );
  }
}
