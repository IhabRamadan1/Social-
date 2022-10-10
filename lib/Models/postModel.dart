class postModel {
  String? name;
  String? uId;
  String? image;
  String? PostImage;
  String? DatTime;
  String? text;

  postModel(this.name, this.PostImage, this.DatTime, this.uId, this.text, this.image);

  postModel.fromjson(Map<String, dynamic>json)
  {
    name = json['name'];
    PostImage = json['PostImage'];
    DatTime = json['DatTime'];
    uId = json['uId'];
    image = json['image'];
    text = json['text'];
  }

  Map<String, dynamic> toMap() {
    return
      {
        'name': name,
        'PostImage': PostImage,
        'DatTime':DatTime,
        'uId': uId,
        'image':image,
        'text': text,
      };
  }
}