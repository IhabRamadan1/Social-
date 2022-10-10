class CommentModel {

  String ?text;
  String? postId;

  CommentModel({
    this.text,
    this.postId,
  });

  CommentModel.fromJson(Map<String, dynamic> json)
  {
    text = json['text'];
    postId = json['postId'];
  }

  Map<String, dynamic> toMap() {
    return {
      'text': text,
      'postId': postId,

    };
  }
}
