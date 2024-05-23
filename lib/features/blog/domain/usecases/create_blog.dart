import 'dart:io';

import 'package:blog_app/core/shared/error/failure.dart';
import 'package:blog_app/core/shared/usecase/usecase.dart';
import 'package:blog_app/features/blog/domain/entities/blog.dart';
import 'package:blog_app/features/blog/domain/repositories/blog_repository.dart';
import 'package:fpdart/fpdart.dart';

/// This use case is responsible for creating a new blog post by using the
/// actual implementation from `BlogRepository`. It takes [CreateBlogParams]
/// object as a pramater.
/// **[CreateBlogParams]** contains user id, title, content, image file and categories.
///
/// The use case returns an `Either<Failure, Blog>` which mean it returns the `Failure` if an error occured while creating the blog , and the `Blog` *(newly created blog)* otherwise.
class CreateBlogUseCase implements Usecase<Blog, CreateBlogParams> {
  final BlogRepository _blogRepository;

  CreateBlogUseCase({required BlogRepository repository})
      : _blogRepository = repository;
  @override
  Future<Either<Failure, Blog>> call(params) async {
    return await _blogRepository.createBlog(
        title: params.title,
        content: params.content,
        categories: params.categories,
        image: params.image,
        userId: params.userId);
  }
}

class CreateBlogParams {
  final String userId;
  final String title;
  final String content;
  final File image;
  final List<String> categories;
  CreateBlogParams({
    required this.userId,
    required this.title,
    required this.content,
    required this.image,
    required this.categories,
  });
}
