// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:blog_app/core/network/connection_checker.dart';
import 'package:blog_app/core/shared/error/exceptions.dart';
import 'package:fpdart/fpdart.dart';

import 'package:blog_app/features/Authentication/data/datasources/remote/auth_remote_source.dart';
import 'package:blog_app/core/shared/entities/user.dart';
import 'package:blog_app/features/Authentication/domain/repositories/auth_repository.dart';
import 'package:blog_app/core/shared/error/failure.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource _authRemoteDataSource;
  final ConnectionChecker _connectionChecker;
  AuthRepositoryImpl({
    required AuthRemoteDataSource authRemoteDataSource,
    required ConnectionChecker connectionChecker,
  })  : _authRemoteDataSource = authRemoteDataSource,
        _connectionChecker = connectionChecker;

  @override
  Future<Either<Failure, User>> signinWithEmailAndPasssword(
          {required String email, required String password}) async =>
      _getUserReusable(() async => await _authRemoteDataSource
          .signinWithEmailAndPassword(email: email, password: password));

  @override
  Future<Either<Failure, User>> signupWithEmailAndPasssword(
          {required String name,
          required String email,
          required String password}) async =>
      _getUserReusable(() async =>
          await _authRemoteDataSource.signupWithEmailAndPassword(
              name: name, email: email, password: password));

  @override
  Future<Either<Failure, User>> getCurrentUser() async {
    try {
      final userData = await _authRemoteDataSource.getCurrentUserData();
      if (userData != null) {
        return Right(userData);
      } else {
        return Left(Failure(message: 'User is not logged in'));
      }
    } on AuthServerException catch (e) {
      return Left(Failure(message: e.message));
    }
  }

  Future<Either<Failure, User>> _getUserReusable(
      Future<User> Function() func) async {
    try {
      bool isConnected = await _connectionChecker.isConnected();
      if (!isConnected) {
        final session = _authRemoteDataSource.currentUserSession;

        if (session == null) {
          return left(Failure(message: 'User not Authenticated'));
        }
        final user = session.user;
        return right(User(id: user.id, name: '', email: user.email ?? ''));
      }

      final userData = await func();
      return Right(userData);
    } on AuthServerException catch (e) {
      return Left(Failure(message: e.message));
    }
  }
}
