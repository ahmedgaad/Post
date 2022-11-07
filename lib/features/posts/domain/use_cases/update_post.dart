import 'package:dartz/dartz.dart';
import 'package:posts_app/features/posts/domain/entities/posts.dart';
import 'package:posts_app/features/posts/domain/repositories/posts_repository.dart';

import '../../../../core/errors/failures.dart';

class UpdatePostUseCase{
  final PostsRepository postsRepository;
  UpdatePostUseCase(this.postsRepository);

  Future<Either<Failure, Unit>> call(Post post) async{
    return await postsRepository.addPost(post);
  }
}