import 'dart:io';

import 'package:blog_app/features/blog/data/models/blog_model.dart';

abstract interface class BlogRemoteDataSource {
  Future<BlogModel> createBlog(BlogModel blogModel);
  Future<String> uploadBlogImage({
    required File imageFile,
    required BlogModel blogModel,
  });
  Future<List<BlogModel>> getAllBlogs();
}
