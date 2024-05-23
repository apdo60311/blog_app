import 'dart:io';

import 'package:blog_app/core/shared/constants/constants.dart';
import 'package:blog_app/core/shared/error/exceptions.dart';
import 'package:blog_app/features/blog/data/datasources/remote/blog_remote_source.dart';
import 'package:blog_app/features/blog/data/models/blog_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

/// This Class Implements the `BlogRemoteDataSource` interface to provide implementation for blogs remote data access.
/// This class uses the **Supabase** Flutter library to interact with a Supabase backend.
class BlogRemoteDatasourceImpl implements BlogRemoteDataSource {
  final SupabaseClient _supabaseClient;

  BlogRemoteDatasourceImpl({
    required SupabaseClient client,
  }) : _supabaseClient = client;

  /// Creates a new blog and insert it into the database.
  ///
  /// Inserts the provided `blogModel` into the `'blogs'` table in the Supabase database.
  ///
  ///
  /// **Throws**
  /// - `BlogServerException`:If an error occured while inserting the blog.
  ///
  /// **Returns**
  /// -  The created BlogModel.
  @override
  Future<BlogModel> createBlog(BlogModel blogModel) async {
    try {
      var blogData = await _supabaseClient
          .from(SupabaseConstants.blogsTable)
          .insert(blogModel.toMap())
          .select();
      return BlogModel.fromMap(blogData.first);
    } catch (e) {
      throw BlogServerException(message: e.toString());
    }
  }

  /// Uploads a blog image to the Supabase storage and returns the public URL of the uploaded image.
  ///
  /// Parameters:
  /// - `imageFile`: The file of the image to be uploaded.
  /// - `blogModel`: The blog model associated with the image to use blog id as a path.
  ///
  /// **Throws:**
  /// - `BlogServerException`: If an error occured while uploading an image.
  ///
  ///**Returns:**
  /// - The public URL of the uploaded image.
  @override
  Future<String> uploadBlogImage(
      {required File imageFile, required BlogModel blogModel}) async {
    try {
      await _supabaseClient.storage
          .from(SupabaseConstants.blogImagesTable)
          .upload(blogModel.id, imageFile);
      return _supabaseClient.storage
          .from(SupabaseConstants.blogImagesTable)
          .getPublicUrl(blogModel.id);
    } catch (e) {
      throw BlogServerException(message: e.toString());
    }
  }

  @override
  Future<List<BlogModel>> getAllBlogs() async {
    try {
      List<Map<String, dynamic>> blogs = await _supabaseClient
          .from(SupabaseConstants.blogsTable)
          .select('*, ${SupabaseConstants.profilesTable}(name)');

      return blogs
          .map(
            (blog) => BlogModel.fromMap(blog)
                .copyWith(publisherName: blog['profiles']['name']),
          )
          .toList();
    } catch (e) {
      throw BlogServerException(message: e.toString());
    }
  }
}
