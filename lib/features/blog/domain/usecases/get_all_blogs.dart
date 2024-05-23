import 'package:blog_app/core/shared/error/failure.dart';
import 'package:blog_app/core/shared/usecase/usecase.dart';
import 'package:blog_app/features/blog/domain/entities/blog.dart';
import 'package:blog_app/features/blog/domain/repositories/blog_repository.dart';
import 'package:fpdart/fpdart.dart';

class GetAllBlogsUsecase implements Usecase<List<Blog>, NoParams> {
  final BlogRepository _blogRepository;

  GetAllBlogsUsecase({required BlogRepository repository})
      : _blogRepository = repository;

  @override
  Future<Either<Failure, List<Blog>>> call(NoParams params) async {
    return await _blogRepository.getAllBlogs();
  }
}
