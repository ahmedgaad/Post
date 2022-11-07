import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:posts_app/features/posts/domain/entities/posts.dart';
import 'package:posts_app/features/posts/presentation/bloc/add_delete_update_posts/add_delete_update_post_bloc.dart';

import '../../../../../core/util/snackbar_message.dart';
import '../../pages/posts_add_update_page.dart';
import '../../pages/posts_page.dart';
import '../posts_page/loading_widget.dart';
import 'delete_dialog_widget.dart';

class PostDetailWidget extends StatelessWidget {
  final Post post;

  const PostDetailWidget({Key? key, required this.post}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        children: [
          Text(
            post.title,
            style: const TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
          ),
          const Divider(
            height: 50.0,
          ),
          Text(
            post.body,
            style: const TextStyle(
              fontSize: 16.0,
            ),
          ),
          const Divider(
            height: 50.0,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton.icon(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (_) => PostsAddUpdatePage(
                                isUpdatePost: true,
                                post: post,
                              )),
                    );
                  },
                  icon: const Icon(Icons.edit),
                  label: const Text("Edit")),
              ElevatedButton.icon(
                  style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all(
                            Colors.redAccent
                        ),
                  ),
                  onPressed: () => deleteDialog(context),
                  icon: const Icon(Icons.delete_outline),
                  label: const Text("Delete"))
            ],
          ),
        ],
      ),
    );
  }

  void deleteDialog(BuildContext context) {
    showDialog(
        context: context,
        builder: (context) {
          return BlocConsumer<AddDeleteUpdatePostBloc,
              AddDeleteUpdatePostState>(
            listener: (context, state) {
              if (state is SuccessAddDeleteUpdatePostState) {
                SnackBarMessage.showSuccessMessage(
                    message: state.message, context: context);
                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (_) => PostsPage()),
                    (route) => false);
              } else if (state is ErrorAddDeleteUpdatePostState) {
                Navigator.of(context).pop();
                SnackBarMessage.showErrorMessage(
                    message: state.message, context: context);
              }
            },
            builder: (context, state) {
              if (state is LoadingAddDeleteUpdatePostState) {
                return const AlertDialog(
                  title: LoadingWidget(),
                );
              }
              return DeleteDialogWidget(postId: post.id!);
            },
          );
        });
  }
}
