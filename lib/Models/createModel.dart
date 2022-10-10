class createUserModel {
  String? name;
  String? phone;
  String? email;
  String? uId;
  String? image;
  String? bio;
  String? cover;
  bool? isVerified ;
  createUserModel(this.name, this.email, this.phone, this.uId, this.isVerified, this.image, this.bio, this.cover);

  createUserModel.fromjson(Map<String, dynamic>json)
  {
    name = json['name'];
    email = json['email'];
    phone = json['phone'];
    uId = json['uId'];
    image = json['image'];
    bio = json['bio'];
    cover = json['cover'];

    isVerified = json['isVerified'];
  }

  Map<String, dynamic> toMap() {
    return
      {
      'name': name,
        'email': email,
        'phone':phone,
        'uId': uId,
        'image':image,
        'bio': bio,
        'cover': cover,
        'isVerified': isVerified,
      };
  }
}