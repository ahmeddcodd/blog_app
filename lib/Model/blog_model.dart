class BlogModel {
  final String? title;
  final String? content;

  BlogModel({required this.title, required this.content});

  BlogModel.fromJson(Map<String, dynamic> json) : 
  this(title: json['title'] as String,
       content: json['content'] as String);

  Map<String, dynamic> toJson()
  {
    return {
      "title" : title,
      "content" : content
    };
  }
  

}
