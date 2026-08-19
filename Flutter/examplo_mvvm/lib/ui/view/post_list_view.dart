import 'package:examplo_mvvm/ui/viewmodel/post_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


class PostListView extends StatelessWidget {
  const PostListView({super.key});

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<PostViewModel>();

    return Scaffold(
      appBar: AppBar(title: const Text('Posts (MVVM + CRUD)')),
      body: Builder(
        builder: (_) {
          if (viewModel.state == ViewState.loading) {
            return const Center(child: CircularProgressIndicator());
          }
          if (viewModel.state == ViewState.error) {
            return Center(child: Text(viewModel.errorMessage ?? 'Error'));
          }
          return RefreshIndicator(
            onRefresh: () => context.read<PostViewModel>().fetchPosts(),
            child: ListView.builder(
              itemCount: viewModel.posts.length,
              itemBuilder: (context, index) {
                final post = viewModel.posts[index];
                return ListTile(
                  title: Text(post.title, maxLines: 1, overflow: TextOverflow.ellipsis),
                  subtitle: Text(post.body, maxLines: 1, overflow: TextOverflow.ellipsis),
                  onTap: () => {},
                  trailing: IconButton(
                    icon: const Icon(Icons.delete, color: Colors.red),
                    onPressed: () => context.read<PostViewModel>().removePost(post.id!),
                  ),
                );
              },
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => {
          // Aquí podrías navegar a una pantalla de creación de post
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
