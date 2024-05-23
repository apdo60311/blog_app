part of 'blog_bloc.dart';

abstract class BlogState extends Equatable {
  const BlogState();

  @override
  List<Object> get props => [];
}

/// Represents the initial state of the `BlogBloc`.
class BlogInitial extends BlogState {}

/// Represents the state of the `BlogBloc` when blog is being loading.
class BlogLoadingState extends BlogState {}

/// Represents the state of the `BlogBloc` when blog is successfully loaded.
/// - The `blog` field contains the successfully loaded blog.
class BlogSuccessState extends BlogState {
  final Blog blog;

  const BlogSuccessState(this.blog);

  @override
  List<Object> get props => [blog];
}

class BlogGetAllBlogsSuccessState extends BlogState {
  final List<Blog> blogs;

  const BlogGetAllBlogsSuccessState(this.blogs);

  @override
  List<Object> get props => [blogs];
}

/// Represents the state of the `BlogBloc` when there is a failure in loading blog.
/// - The `message` field contains the error message.

class BlogFailureState extends BlogState {
  final String message;

  const BlogFailureState(this.message);
}
