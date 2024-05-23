/// This class contains the data and properties of a blog object.
/// 1. `id` The unique identifier of the blog post.
/// 2. `userId` The id of the user who created the blog.
/// 3. `title` The title of the blog.
/// 4. `content` The content of the blog.
/// 5. `imageUrl` The URL of blog's image.
/// 6. `categories` The categories that the blog belongs to.
/// 7. `updatedAt` The timestamp when the blog is last modified.
class Blog {
  final String id;
  final String userId;
  final String title;
  final String content;
  final String imageUrl;
  final List categories;
  final DateTime updatedAt;
  String? publisherName;
  Blog({
    required this.id,
    required this.userId,
    required this.title,
    required this.content,
    required this.imageUrl,
    required this.categories,
    required this.updatedAt,
    this.publisherName,
  });
}
