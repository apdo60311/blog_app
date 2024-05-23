import 'package:blog_app/core/shared/entities/user.dart';
import 'package:blog_app/core/shared/error/failure.dart';
import 'package:fpdart/fpdart.dart';

abstract interface class AuthRepository {
  Future<Either<Failure, User>> signupWithEmailAndPasssword({
    required String name,
    required String email,
    required String password,
  });

  Future<Either<Failure, User>> signinWithEmailAndPasssword({
    required String email,
    required String password,
  });

  Future<Either<Failure, User>> getCurrentUser();
}
