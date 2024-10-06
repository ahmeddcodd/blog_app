import 'package:blog_app/API/api_services.dart';
import 'package:blog_app/Model/blog_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final Provider<ApiServices> apiServiceProvider = Provider<ApiServices>((_) => ApiServices());

final FutureProvider<List<BlogModel>?> blogsList = FutureProvider<List<BlogModel>?>((ref) async {
  final ApiServices apiServices = ref.watch(apiServiceProvider);
  final List<BlogModel>? blogs = await apiServices.getPost();
  return blogs;
});
