// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:io';

import 'package:blog_app/core/network/connection_checker.dart';
import 'package:blog_app/core/shared/error/exceptions.dart';
import 'package:blog_app/features/blog/data/datasources/local/blog_local_datasource.dart';
import 'package:blog_app/features/blog/data/models/blog_model.dart';
import 'package:fpdart/fpdart.dart';

import 'package:blog_app/core/shared/error/failure.dart';
import 'package:blog_app/features/blog/data/datasources/remote/blog_remote_source.dart';
import 'package:blog_app/features/blog/domain/entities/blog.dart';
import 'package:blog_app/features/blog/domain/repositories/blog_repository.dart';
import 'package:uuid/uuid.dart';

class BlogRepositoryImpl implements BlogRepository {
  final BlogRemoteDataSource _blogRemoteDataSource;
  final BlogLocalDataSource _blogLocalDataSource;
  final ConnectionChecker _connectionChecker;
  BlogRepositoryImpl({
    required BlogRemoteDataSource blogRemoteDataSource,
    required BlogLocalDataSource blogLocalDataSource,
    required ConnectionChecker connectionChecker,
  })  : _blogRemoteDataSource = blogRemoteDataSource,
        _blogLocalDataSource = blogLocalDataSource,
        _connectionChecker = connectionChecker;

  @override
  Future<Either<Failure, Blog>> createBlog(
      {required String title,
      required String content,
      required List<String> categories,
      required File image,
      required String userId}) async {
    try {
      if (!await _connectionChecker.isConnected()) {
        return left(Failure(message: 'No Internet Connection!!'));
      }

      String newBlogId = const Uuid().v1();

      BlogModel newBlogModel = BlogModel(
        id: newBlogId,
        userId: userId,
        title: title,
        content: content,
        imageUrl: '',
        categories: categories,
        updatedAt: DateTime.now(),
      );

      String imageUrl = await _blogRemoteDataSource.uploadBlogImage(
        imageFile: image,
        blogModel: newBlogModel,
      );

      newBlogModel = newBlogModel.copyWith(imageUrl: imageUrl);

      BlogModel newBlogData =
          await _blogRemoteDataSource.createBlog(newBlogModel);
      return right(newBlogData);
    } on BlogServerException catch (e) {
      return left(Failure(message: e.message));
    }
  }

  @override
  Future<Either<Failure, List<Blog>>> getAllBlogs() async {
    try {
      if (!await _connectionChecker.isConnected()) {
        final blogs = _blogLocalDataSource.loadBlogs();
        return right(blogs);
      }

      final blogs = await _blogRemoteDataSource.getAllBlogs();
      return right(blogs);
    } on BlogServerException catch (e) {
      return left(Failure(message: e.message));
    }
  }
}
