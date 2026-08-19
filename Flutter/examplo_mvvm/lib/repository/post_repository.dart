import 'package:dio/dio.dart';
import '../core/network/api_client.dart';
import '../core/constants/api_constants.dart';
import '../models/post_model.dart';

class PostRepository {
  final Dio _dio = ApiClient().dio;

  // READ — obtener todos los posts
  Future<List<PostModel>> getPosts() async {
    final response = await _dio.get(ApiConstants.posts);
    final data = response.data as List;
    return data.map((json) => PostModel.fromJson(json)).toList();
  }

  // READ — obtener un post por id
  Future<PostModel> getPostById(int id) async {
    final response = await _dio.get('${ApiConstants.posts}/$id');
    return PostModel.fromJson(response.data);
  }

  // CREATE
  Future<PostModel> createPost(PostModel post) async {
    final response = await _dio.post(
      ApiConstants.posts,
      data: post.toJson(),
    );
    return PostModel.fromJson(response.data);
  }

  // UPDATE
  Future<PostModel> updatePost(PostModel post) async {
    final response = await _dio.put(
      '${ApiConstants.posts}/${post.id}',
      data: post.toJson(),
    );
    return PostModel.fromJson(response.data);
  }

  // DELETE
  Future<void> deletePost(int id) async {
    await _dio.delete('${ApiConstants.posts}/$id');
  }
}