import 'dart:async';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:blog_app/core/shared/usecase/usecase.dart';
import 'package:blog_app/features/blog/domain/entities/blog.dart';
import 'package:blog_app/features/blog/domain/usecases/create_blog.dart';
import 'package:blog_app/features/blog/domain/usecases/get_all_blogs.dart';
import 'package:equatable/equatable.dart';

part 'blog_event.dart';
part 'blog_state.dart';

class BlogBloc extends Bloc<BlogEvent, BlogState> {
  final CreateBlogUseCase _createBlogUseCase;
  final GetAllBlogsUsecase _getAllBlogsUsecase;
  BlogBloc({
    required CreateBlogUseCase createBlogUseCase,
    required GetAllBlogsUsecase getAllBlogsUsecase,
  })  : _createBlogUseCase = createBlogUseCase,
        _getAllBlogsUsecase = getAllBlogsUsecase,
        super(BlogInitial()) {
    on<BlogEvent>((event, emit) {
      emit(BlogLoadingState());
    });
    on<BlogCreateBlog>(_onCreateBlog);
    on<BlogGetAllBlogs>(_onGetAllBlogs);
  }

  FutureOr<void> _onCreateBlog(event, emit) async {
    try {
      var blog = await _createBlogUseCase(CreateBlogParams(
          userId: event.userId,
          title: event.title,
          content: event.content,
          image: event.image,
          categories: event.categories));
      blog.fold(
        (failure) => emit(BlogFailureState(failure.message)),
        (blog) => emit(BlogSuccessState(blog)),
      );
    } catch (e) {
      emit(BlogFailureState(e.toString()));
    }
  }

  FutureOr<void> _onGetAllBlogs(
      BlogGetAllBlogs event, Emitter<BlogState> emit) async {
    final res = await _getAllBlogsUsecase(NoParams());

    res.fold(
      (failure) => emit(BlogFailureState(failure.message)),
      (blogs) => emit(BlogGetAllBlogsSuccessState(blogs)),
    );
  }
}
