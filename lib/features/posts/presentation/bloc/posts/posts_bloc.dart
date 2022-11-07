import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:posts_app/core/errors/failures.dart';
import 'package:posts_app/core/strings_manager.dart';

import '../../../domain/entities/posts.dart';
import '../../../domain/use_cases/get_all_posts.dart';

part 'posts_event.dart';

part 'posts_state.dart';

class PostsBloc extends Bloc<PostsEvent, PostsState> {
  final GetAllPostsUseCase getAllPosts;

  PostsBloc({required this.getAllPosts}) : super(PostsInitial()) {
    on<PostsEvent>((event, emit) async {
      if (event is GetAllPostsEvent) {
        emit(LoadingPostsState());
        final failureOrPosts = await getAllPosts();
        emit(_mapFailureOrPostsState(failureOrPosts));
        /*failureOrPosts.fold(
                (failure) {
                  emit(ErrorPostsState(message: _mapFailureToMessage(failure)));
                },
                (posts) {
                  emit(SuccessPostsState(posts: posts));
                }
        );*/
      } else if (event is RefreshPostsEvent) {
        emit(LoadingPostsState());
        final failureOrPosts = await getAllPosts();
        emit(_mapFailureOrPostsState(failureOrPosts));
        /*failureOrPosts.fold(
                (failure) {
              emit(ErrorPostsState(message: _mapFailureToMessage(failure)));
            },
                (posts) {
              emit(SuccessPostsState(posts: posts));
            }
        );*/
      }
    });
  }

  PostsState _mapFailureOrPostsState(Either<Failure, List<Post>> either){
    return either.fold(
            (failure) => ErrorPostsState(message: _mapFailureToMessage(failure)),
            (posts) => SuccessPostsState(posts: posts),
    );
  }

  String _mapFailureToMessage(Failure failure){
    switch(failure.runtimeType) {
      case ServerFailure:
        return SERVER_FAILURE_MESSAGE;
      case EmptyCacheFailure:
        return EMPTY_CACHE_FAILURE_MESSAGE;
      case OfflineFailure:
        return OFFLINE_FAILURE_MESSAGE;
      default:
        return "Unexpected Error, Please try again later";
    }

  }
}
