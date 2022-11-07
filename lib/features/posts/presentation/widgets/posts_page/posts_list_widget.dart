import 'package:flutter/material.dart';
import 'package:posts_app/features/posts/domain/entities/posts.dart';

import '../../pages/post_detail_page.dart';

class PostsListWidget extends StatelessWidget {
  final List<Post> posts;

  const PostsListWidget({Key? key, required this.posts}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      separatorBuilder: (context, index) => const Divider(
        thickness: 1,
      ),
      itemCount: posts.length,
      itemBuilder: (context, index) {
        return ListTile(
          leading: Text(posts[index].id.toString()),
          title: Text(
            posts[index].title,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0),
          ),
          subtitle: Text(
            posts[index].body,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0),
          ),
          contentPadding: const EdgeInsets.symmetric(horizontal: 10.0),
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (_) => PostDetailPage(
                          post: posts[index],
                        )));
          },
        );
      },
    );
  }
}
