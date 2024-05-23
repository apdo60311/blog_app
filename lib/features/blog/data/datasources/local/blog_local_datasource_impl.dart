import 'package:blog_app/features/blog/data/datasources/local/blog_local_datasource.dart';
import 'package:blog_app/features/blog/data/models/blog_model.dart';
import 'package:hive/hive.dart';

class BlogLocalDataSourceImpl implements BlogLocalDataSource {
  final Box _box;

  BlogLocalDataSourceImpl({required Box box}) : _box = box;

  @override
  void storeBlogs({required List<BlogModel> blogs}) {
    _box.clear();
    for (var blog in blogs) {
      _box.put(blog.id, blog.toMap());
    }
  }

  @override
  List<BlogModel> loadBlogs() {
    return _box.values.map((blog) => BlogModel.fromMap(blog)).toList();
  }
}
