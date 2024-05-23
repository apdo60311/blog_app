import 'package:blog_app/core/shared/entities/user.dart';
import 'package:blog_app/features/Authentication/domain/repositories/auth_repository.dart';
import 'package:blog_app/core/shared/error/failure.dart';
import 'package:blog_app/core/shared/usecase/usecase.dart';
import 'package:fpdart/fpdart.dart';

class UserSignUp implements Usecase<User, UserSignUpParams> {
  final AuthRepository _authRepository;

  UserSignUp({required AuthRepository repository})
      : _authRepository = repository;

  @override
  Future<Either<Failure, User>> call(UserSignUpParams params) async {
    return await _authRepository.signupWithEmailAndPasssword(
        name: params.name, email: params.email, password: params.password);
  }
}

class UserSignUpParams {
  final String name;
  final String email;
  final String password;

  UserSignUpParams(
      {required this.name, required this.email, required this.password});
}
