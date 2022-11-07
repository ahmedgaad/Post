part of 'posts_bloc.dart';

abstract class PostsState extends Equatable {
  const PostsState();
}

class PostsInitial extends PostsState {
  @override
  List<Object> get props => [];
}

class LoadingPostsState extends PostsState {
  @override
  List<Object?> get props => [];
}
class SuccessPostsState extends PostsState{
  final List<Post> posts;
  const SuccessPostsState({required this.posts});

  @override
  List<Object?> get props => [posts];
}
class ErrorPostsState extends PostsState{
  final String message;
  const ErrorPostsState({required this.message});

  @override
  List<Object?> get props => [message];
}
