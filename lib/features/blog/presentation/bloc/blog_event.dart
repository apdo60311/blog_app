part of 'blog_bloc.dart';

abstract class BlogEvent extends Equatable {
  const BlogEvent();

  @override
  List<Object> get props => [];
}

/// Represents an event to create a new blog.
///
/// This event is used to start the creation of a new blog.
///
/// - The `userId` is the unique identifier of the user creating the blog post.
/// - The `title` is the title of the blog post.
/// - The `content` is the content of the blog post.
/// - The `image` is the image associated with the blog post.
/// - The `categories` is a list of categories the blog post belongs to.
class BlogCreateBlog extends BlogEvent {
  final String userId;
  final String title;
  final String content;
  final File image;
  final List<String> categories;
  const BlogCreateBlog({
    required this.userId,
    required this.title,
    required this.content,
    required this.image,
    required this.categories,
  });

  @override
  List<Object> get props => [userId, title, content, image, categories];
}

class BlogGetAllBlogs extends BlogEvent {
  const BlogGetAllBlogs();
}

class GetBlog extends BlogEvent {
  final String blogId;
  const GetBlog({required this.blogId});

  @override
  List<Object> get props => [blogId];
}
