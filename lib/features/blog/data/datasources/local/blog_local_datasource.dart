import 'package:blog_app/features/blog/data/models/blog_model.dart';

abstract interface class BlogLocalDataSource {
  void storeBlogs({required List<BlogModel> blogs});
  List<BlogModel> loadBlogs();
}
