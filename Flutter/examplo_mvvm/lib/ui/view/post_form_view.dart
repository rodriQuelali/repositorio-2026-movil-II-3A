import 'package:examplo_mvvm/models/post_model.dart';
import 'package:examplo_mvvm/ui/viewmodel/post_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


class PostFormView extends StatefulWidget {
  final PostModel? post; // null = creando, no null = editando

  const PostFormView({super.key, this.post});

  @override
  State<PostFormView> createState() => _PostFormViewState();
}

class _PostFormViewState extends State<PostFormView> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _titleController;
  late TextEditingController _bodyController;

  bool get isEditing => widget.post != null;
  

  @override
  void initState() {
    super.initState();
    print('Data....................: $widget.post');
    _titleController = TextEditingController(text: widget.post?.title ?? '');
    _bodyController = TextEditingController(text: widget.post?.body ?? '');
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;
    
    final viewModel = context.read<PostViewModel>();
    final post = PostModel(
      id: widget.post?.id,
      userId: widget.post?.userId ?? 1,
      title: _titleController.text,
      body: _bodyController.text,
    );

    final success = isEditing
        ? await viewModel.editPost(post)
        : await viewModel.addPost(post);

    if (success && mounted) {
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(isEditing ? 'Editar Post' : 'Nuevo Post')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _titleController,
                decoration: const InputDecoration(labelText: 'Título'),
                validator: (v) => (v == null || v.isEmpty) ? 'Requerido' : null,
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _bodyController,
                decoration: const InputDecoration(labelText: 'Contenido'),
                maxLines: 4,
                validator: (v) => (v == null || v.isEmpty) ? 'Requerido' : null,
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: _submit,
                child: Text(isEditing ? 'Actualizar' : 'Crear'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}