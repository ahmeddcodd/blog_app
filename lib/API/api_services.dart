import "package:blog_app/Model/blog_model.dart";
import "package:dio/dio.dart";
import "package:dio/dio.dart" as dio;
import "package:flutter/cupertino.dart";

class ApiServices {
  final Dio _dio = Dio(BaseOptions(
      baseUrl: "http://10.0.2.2:8000/api/",
      connectTimeout: const Duration(milliseconds: 5000),
      receiveTimeout: const Duration(milliseconds: 10000)));

  Future<void> addPost(Map<String, dynamic> post) async {
    try {
      debugPrint(post.toString());
      final dio.Response response = await _dio.post("/createpost", data: post);
      debugPrint("This is the response when added ${response.toString()}");
    } catch (e) {
      debugPrint("Unable to send the details to the server $e");
    }
  }

  Future<List<BlogModel>?> getPost() async {
    try {
      final dio.Response response = await _dio.get("/getpost");
      debugPrint(response.toString());
      final responseBlogsList = response.data as List;
      final blogList = responseBlogsList.map((blog) {
        return BlogModel.fromJson(blog);
      }).toList();
      debugPrint("This is a blog list: $blogList");
      return blogList;
    } catch (e) {
      debugPrint("The error is $e");
      return null;
    }
  }
}
