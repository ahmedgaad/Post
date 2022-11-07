import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:posts_app/core/util/snackbar_message.dart';
import 'package:posts_app/features/posts/domain/entities/posts.dart';
import 'package:posts_app/features/posts/presentation/bloc/add_delete_update_posts/add_delete_update_post_bloc.dart';
import 'package:posts_app/features/posts/presentation/pages/posts_page.dart';
import 'package:posts_app/features/posts/presentation/widgets/posts_page/loading_widget.dart';

import '../widgets/posts_add_update_page/form_widget.dart';

class PostsAddUpdatePage extends StatelessWidget {
  final Post? post;
  final bool isUpdatePost;

  const PostsAddUpdatePage({Key? key, this.post, required this.isUpdatePost})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(isUpdatePost ? "Edit Post" : "Add Post"),
      ),
      body: BlocConsumer<AddDeleteUpdatePostBloc, AddDeleteUpdatePostState>(
        listener: (context, state) {
          if (state is SuccessAddDeleteUpdatePostState) {
            SnackBarMessage
                .showSuccessMessage(message: state.message, context: context);
            Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(builder: (_) => const PostsPage()),
                (route) => false);
          } else if (state is ErrorAddDeleteUpdatePostState) {
            SnackBarMessage
                .showErrorMessage(message: state.message, context: context);
          }
        },
        builder: (context, state) {
          if (state is LoadingAddDeleteUpdatePostState) {
            return const LoadingWidget();
          }
          return FormWidget(
            isUpdatePost : isUpdatePost, post: isUpdatePost ? post : null,
          );
        },
      ),
    );
  }
}
