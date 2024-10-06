import "package:blog_app/API/api_services.dart";
import "package:blog_app/Model/blog_model.dart";
import "package:blog_app/Provider/post_provider.dart";
import "package:blog_app/Widget/blog_card.dart";
import "package:flutter/material.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";

class CreateBlog extends ConsumerWidget {
  CreateBlog({super.key});

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _contentController = TextEditingController();
  final ApiServices _apiServices = ApiServices();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.add), onPressed: () => alert(context, ref)),
      body: SafeArea(child: Consumer(builder: (context, ref, child) {
        final blogs = ref.watch(blogsList);
        return blogs.when(
            data: (data) {
              return ListView.separated(
                  itemCount: data!.length,
                  itemBuilder: (context, index) {
                    return BlogCard(title: data[index].title);
                  },
                  separatorBuilder: (context, index) =>
                      const SizedBox(height: 5));
            },
            error: (_, __) => const Text("Error, Cant get the blogs"),
            loading: () => const CircularProgressIndicator());
      })),
    );
  }

  Future<dynamic> alert(BuildContext context, WidgetRef ref) {
    return showDialog(
        context: context,
        builder: (context) => AlertDialog(
              actions: [
                ElevatedButton(
                  child: const Text("Create"),
                  onPressed: () async {
                    final Map<String, dynamic> postData = BlogModel(
                            title: _titleController.text,
                            content: _contentController.text)
                        .toJson();

                    await _apiServices.addPost(postData);
                    // ignore: unused_result
                    ref.refresh(blogsList);
//Here I have to use the ref.refresh Unfortunatley because the future provider is called once and there is no stream set up so, I have refresh to recall the api to get the data for now.
                    Navigator.pop(context);
                  },
                ),
                ElevatedButton(
                    child: const Text("Cancel"),
                    onPressed: () => Navigator.pop(context))
              ],
              title: const Text("Create Blog"),
              contentPadding: const EdgeInsets.all(5),
              content: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    TextField(
                      controller: _titleController,
                      decoration:
                          const InputDecoration(hintText: "Enter Title"),
                    ),
                    const SizedBox(height: 10),
                    TextField(
                      controller: _contentController,
                      decoration:
                          const InputDecoration(hintText: "Enter content"),
                    ),
                  ],
                ),
              ),
            ));
  }
}
