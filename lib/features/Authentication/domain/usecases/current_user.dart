import 'package:blog_app/core/shared/entities/user.dart';
import 'package:blog_app/features/Authentication/domain/repositories/auth_repository.dart';
import 'package:blog_app/core/shared/error/failure.dart';
import 'package:blog_app/core/shared/usecase/usecase.dart';
import 'package:fpdart/fpdart.dart';

class CurrentUser implements Usecase<User, NoParams> {
  final AuthRepository _authRepository;

  CurrentUser({required AuthRepository repository})
      : _authRepository = repository;

  @override
  Future<Either<Failure, User>> call(NoParams params) async {
    return await _authRepository.getCurrentUser();
  }
}
