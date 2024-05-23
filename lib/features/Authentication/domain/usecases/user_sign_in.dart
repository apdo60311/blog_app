import 'package:blog_app/core/shared/entities/user.dart';
import 'package:blog_app/features/Authentication/domain/repositories/auth_repository.dart';
import 'package:blog_app/core/shared/error/failure.dart';
import 'package:blog_app/core/shared/usecase/usecase.dart';
import 'package:fpdart/fpdart.dart';

class UserSignIn implements Usecase<User, UserSignInParams> {
  final AuthRepository _authRepository;

  UserSignIn({required AuthRepository repository})
      : _authRepository = repository;

  @override
  Future<Either<Failure, User>> call(UserSignInParams params) async {
    return await _authRepository.signinWithEmailAndPasssword(
        email: params.email, password: params.password);
  }
}

class UserSignInParams {
  final String email;
  final String password;

  UserSignInParams({required this.email, required this.password});
}
