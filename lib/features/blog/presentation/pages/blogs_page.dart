import 'package:blog_app/core/shared/components/loading_indecator.dart';
import 'package:blog_app/core/themes/app_colors.dart';
import 'package:blog_app/core/utils/snackbars.dart';
import 'package:blog_app/features/blog/presentation/bloc/blog_bloc.dart';
import 'package:blog_app/features/blog/presentation/widgets/blog_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BlogsPage extends StatefulWidget {
  const BlogsPage({super.key});

  @override
  State<BlogsPage> createState() => _BlogsPageState();
}

class _BlogsPageState extends State<BlogsPage> {
  @override
  void initState() {
    context.read<BlogBloc>().add(const BlogGetAllBlogs());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Blogs'),
      ),
      body: BlocConsumer<BlogBloc, BlogState>(
        listener: (context, state) {
          if (state is BlogFailureState) {
            showSnackBar(context, state.message, AppColors.errorColor);
          }
        },
        builder: (context, state) {
          if (state is BlogLoadingState) {
            return const LoadingIndecator();
          }
          if (state is BlogGetAllBlogsSuccessState) {
            return ListView.separated(
              itemBuilder: (BuildContext context, int index) {
                return BlogCard(
                  blog: state.blogs[index],
                  color: _getCardColor(index),
                );
              },
              separatorBuilder: (BuildContext context, int index) =>
                  const SizedBox(height: 10.0),
              itemCount: state.blogs.length,
            );
          } else {
            return const SizedBox();
          }
        },
      ),
    );
  }

  Color _getCardColor(int index) {
    return (index % 3 == 0)
        ? AppColors.gradient1
        : (index % 3 == 1)
            ? AppColors.gradient2
            : AppColors.gradient3;
  }
}
