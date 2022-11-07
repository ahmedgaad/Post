import 'package:dartz/dartz.dart';
import 'package:posts_app/features/posts/domain/entities/posts.dart';

import '../../../../core/errors/failures.dart';

abstract class  PostsRepository{
  Future<Either<Failure, List<Post>>> getAllPosts();
  Future<Either<Failure, Unit>> deletePost(int id);
  Future<Either<Failure, Unit>> updatePost(Post post);
  Future<Either<Failure, Unit>> addPost(Post post);
}