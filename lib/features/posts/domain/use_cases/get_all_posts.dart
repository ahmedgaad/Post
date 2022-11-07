import 'package:dartz/dartz.dart';
import 'package:posts_app/features/posts/domain/repositories/posts_repository.dart';

import '../../../../core/errors/failures.dart';
import '../entities/posts.dart';

/*Dart allows the user to create a callable class
which allows the instance of the class to be called as a function.
To allow an instance of your Dart class to be called like a function,
implement the call() method.*/
class GetAllPostsUseCase{
  //Instance(object) from PostsRepository
  final PostsRepository postsRepository;
  GetAllPostsUseCase(this.postsRepository);

  Future<Either<Failure, List<Post>>> call() async{
    return await postsRepository.getAllPosts();
  }
}