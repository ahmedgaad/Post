import 'package:dartz/dartz.dart';
import 'package:posts_app/features/posts/domain/repositories/posts_repository.dart';

import '../../../../core/errors/failures.dart';

class DeletePostUseCase{
  final PostsRepository postsRepository;
  DeletePostUseCase(this.postsRepository);

  Future<Either<Failure, Unit>> call(int postId) async{
    return await postsRepository.deletePost(postId);
  }
}