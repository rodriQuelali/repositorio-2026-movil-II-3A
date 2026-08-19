import 'package:examplo_mvvm/models/post_model.dart';
import 'package:examplo_mvvm/repository/post_repository.dart';
import 'package:flutter/material.dart';


enum ViewState { idle, loading, error }

class PostViewModel extends ChangeNotifier {
  final PostRepository _repository = PostRepository();

  List<PostModel> _posts = [];
  List<PostModel> get posts => _posts;

  ViewState _state = ViewState.idle;
  ViewState get state => _state;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  void _setState(ViewState newState) {
    _state = newState;
    notifyListeners();
  }

  Future<void> fetchPosts() async {
    _setState(ViewState.loading);
    try {
      _posts = await _repository.getPosts();
      _setState(ViewState.idle);
    } catch (e) {
      _errorMessage = 'Error al cargar los posts: $e';
      _setState(ViewState.error);
    }
  }

  Future<bool> addPost(PostModel post) async {
    try {
      final newPost = await _repository.createPost(post);
      _posts.insert(0, newPost);
      notifyListeners();
      return true;
    } catch (e) {
      _errorMessage = 'Error al crear el post: $e';
      notifyListeners();
      return false;
    }
  }

  Future<bool> editPost(PostModel post) async {
    try {
      final updated = await _repository.updatePost(post);
      final index = _posts.indexWhere((p) => p.id == updated.id);
      if (index != -1) {
        _posts[index] = updated;
        notifyListeners();
      }
      return true;
    } catch (e) {
      _errorMessage = 'Error al actualizar el post: $e';
      notifyListeners();
      return false;
    }
  }

  Future<bool> removePost(int id) async {
    try {
      await _repository.deletePost(id);
      _posts.removeWhere((p) => p.id == id);
      notifyListeners();
      return true;
    } catch (e) {
      _errorMessage = 'Error al eliminar el post: $e';
      notifyListeners();
      return false;
    }
  }
}