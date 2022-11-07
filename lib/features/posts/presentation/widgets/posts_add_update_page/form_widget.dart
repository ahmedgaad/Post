import 'package:flutter/material.dart';
import 'package:posts_app/features/posts/domain/entities/posts.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:posts_app/features/posts/presentation/widgets/posts_add_update_page/text_form_filed_widget.dart';

import '../../bloc/add_delete_update_posts/add_delete_update_post_bloc.dart';
import 'form_submit_btn.dart';

class FormWidget extends StatefulWidget {
  final bool isUpdatePost;
  final Post? post;

  const FormWidget({Key? key, required this.isUpdatePost, this.post})
      : super(key: key);

  @override
  _FormWidgetState createState() => _FormWidgetState();
}

class _FormWidgetState extends State<FormWidget> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _bodyController = TextEditingController();

  @override
  void initState() {
    if (widget.isUpdatePost) {
      _titleController.text = widget.post!.title;
      _bodyController.text = widget.post!.body;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
        key: _formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            //TextField - title
            TextFormFiledWidget(
                controller: _titleController, name: "Title", multiLine: false),
            /*
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 20.0,
                vertical: 10.0,
              ),
              child: TextFormField(
                controller: _titleController,
                validator: (val) {
                  if (val!.isEmpty) {
                    return "Title Can't be empty";
                  }
                  return null;
                },
                decoration: const InputDecoration(
                  hintText: "Title",
                ),
              ),
            ),
*/

            //TextField - body
            TextFormFiledWidget(
                controller: _bodyController, name: "Body", multiLine: true),
            /*Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 20.0,
                vertical: 10.0,
              ),
              child: TextFormField(
                controller: _bodyController,
                validator: (val) {
                  if (val!.isEmpty) {
                    return "Body Can't be empty";
                  }
                  return null;
                },
                decoration: const InputDecoration(
                  hintText: "Body",
                ),
                maxLines: 6,
                minLines: 6,
              ),
            ),*/


            FormSubmitBtn(
              onPressed: validateFormThenUpdateOrAddPost,
              isUpdatePost: widget.isUpdatePost,
            ),
            /*ElevatedButton.icon(
              onPressed: validateFormThenUpdateOrAddPost,
              icon: widget.isUpdatePost
                  ? const Icon(Icons.edit)
                  : const Icon(Icons.add),
              label: Text(widget.isUpdatePost ? "Update" : "Add"),
            ),*/

          ],
        ));
  }

  void validateFormThenUpdateOrAddPost() {
    final isValid = _formKey.currentState!.validate();
    if (isValid) {
      final post = Post(
          id: widget.isUpdatePost ? widget.post!.id : null,
          title: _titleController.text,
          body: _bodyController.text);
      if (widget.isUpdatePost) {
        BlocProvider.of<AddDeleteUpdatePostBloc>(context)
            .add(UpdatePostEvent(post: post));
      } else {
        BlocProvider.of<AddDeleteUpdatePostBloc>(context)
            .add(AddPostEvent(post: post));
      }
    }
  }
}
