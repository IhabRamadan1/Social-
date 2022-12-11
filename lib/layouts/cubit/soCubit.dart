import 'dart:io';
import 'package:chat_app/Models/LoginModel.dart';
import 'package:chat_app/Models/commentModel.dart';
import 'package:chat_app/Models/messageModel.dart';
import 'package:chat_app/Models/postModel.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:chat_app/Models/createModel.dart';
import 'package:chat_app/Modeules/addPost/addPost.dart';
import 'package:chat_app/Modeules/chats/chats.dart';
import 'package:chat_app/Modeules/feeds/feeds.dart';
import 'package:chat_app/Modeules/settings/settings.dart';
import 'package:chat_app/Modeules/users/users.dart';
import 'package:chat_app/shared/constants.dart';
import 'package:chat_app/layouts/cubit/soStates.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppCubit extends Cubit<AppStates>
{
  AppCubit():super(soInitia());
  static AppCubit get(context) => BlocProvider.of(context);
    createUserModel? userModel;
  void getUserData()
  {
    emit(soLoading());
    FirebaseFirestore.instance.collection('users').doc(uId).get().then((value){
      userModel = createUserModel.fromjson(value.data()!);
      print(value.data());
      emit(soSuccess());
    }).catchError((onError){
      print('Sssssssssssssssssssssssssss${onError.toString()}');
      emit(soError(onError));
    });
  }
  int currentIndex =0;
  List <Widget> screens = [
   feedsScreen(),
   chatScreen(),
    postScreen(),
   usersScreen(),
    settingsScreen(),

  ];
  List <String> titles = [
    'Home',
    'Chat',
    'post',
    'User',
    'Settings',

  ];

  void bottomChange(int index)
  {
    if(index==2) emit(AddPostState());
    else
      {
        currentIndex=index;
        emit(soChangeButton());
      }
  }
  
  File? profileImage;
  var picker = ImagePicker();
  Future<void> getProfileImage() async
  {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);
    if(pickedFile != null)
      {
        profileImage = File(pickedFile.path);
        emit(successProfileState());
      }
    else
      {
        print("no image selected");
        emit(errorProfileState());
      }
  }

  File? coverImage;
  Future<void> getCoverImage() async
  {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);
    if(pickedFile != null)
    {
      coverImage = File(pickedFile.path);
      emit(successCoverState());
    }
    else
    {
      print("no image selected");
      emit(errorCoverState());
    }
  }

  String profileUrl ='';
  void uploadProfile( {required String name,
  required String bio,
  required String phone,})
  {
    FirebaseStorage.instance.
    ref().
    child('users/${Uri.file(profileImage!.path).pathSegments.last}').
    putFile(profileImage!).then((value){
      value.ref.getDownloadURL().then((value)
      {
        updateUser(name: name, bio: bio, phone: phone, image: value);
        emit(successuploadProfileState());
      }).catchError((onError){
        emit(erroruploadProfileState());
        print(onError.toString());
      });
    }).catchError((e){
      emit(erroruploadProfileState());
    });
  }


  String coverUrl='';
  void uploadCover({required String name,
    required String bio,
    required String phone,})
  {
    FirebaseStorage.instance.
    ref().
    child('users/${Uri.file(coverImage!.path).pathSegments.last}').
    putFile(coverImage!).then((value){
      value.ref.getDownloadURL().then((value)
      {
        updateUser(name: name, bio: bio, phone: phone, cover: value);
        emit(successuploadCoverState());
      }).catchError((onError){
        emit(erroruploadCoverState());
      });
    }).catchError((e){
      emit(erroruploadCoverState());
    });
  }

  void updateUser(
  {
  required String name,
    required String bio,
    required String phone,
    String? cover,
    String? image,
}
      )
  {
    emit(loadingUpdateState());
        createUserModel user = createUserModel(
            name,
            phone,
            userModel!.email,
            userModel!.uId,
            false,
            image??userModel!.image,
            bio,
            cover??userModel!.cover,
        );
        FirebaseFirestore.instance.collection('users').
        doc(userModel!.uId).
        update(user.toMap()).then((value)
        {
          getUserData();
        }).catchError((onError){
          emit(errorUpdateState());
        });
  }

  File? postImage;
  Future<void> getPostImage() async
  {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);
    if(pickedFile != null)
    {
      postImage = File(pickedFile.path);
      emit(successProfileState());
    }
    else
    {
      print("no image selected");
      emit(errorProfileState());
    }
  }

  void uploadPostImage({
    required String Datetime,
    required String text,})
  {
    emit(loadingPostImageState());
    FirebaseStorage.instance.
    ref().
    child('users/${Uri.file(postImage!.path).pathSegments.last}').
    putFile(postImage!).then((value){
      value.ref.getDownloadURL().then((value){
        createPost(DatTime: Datetime, text: text, Postimage: value);
        emit(successPostImageState());
      }).catchError((onError){
        emit(errorPostImageState());
      });
    }).catchError((e){
      emit(errorPostImageState());
    });
  }

  void createPost({
  required String DatTime,
    required String text,
    String? Postimage,
})
  {
    emit(loadingCreatePostState());
    postModel model = postModel(userModel!.name,
        Postimage??'',
        DatTime,
        userModel!.uId,
        text,
        userModel!.image
    );
    FirebaseFirestore.instance.collection('posts').add(model.toMap()).then((value){
      emit(successCreatePostState());
    }).catchError((onError){
      emit(errorCreatePostState());
    });
  }

void removePostImage()
{
  postImage = null;
  emit(removePostImageState());
}

List <postModel> posts =[];
List<String> PostId=[];
List<int> likes =[];
List<int> comments =[];

void getAllPosts()
{
  emit(loadinggetAllPostState());
  FirebaseFirestore.instance.collection('posts').get().then((value){
    value.docs.forEach((element)
    {
      element.reference.collection('like').get().then((value){
        likes.add(value.docs.length);
        PostId.add(element.id);
        posts.add(postModel.fromjson(element.data()));
        emit(successgetAllPostState());
      }).catchError((onError){
      });
      element.reference.collection('comments').get().then((value){
        //print("hhhhhhhhhhhhhhhhh${value}");
        comments.add(value.docs.length);
      }).catchError((onError){

      });
    });
  }).catchError((onError){
    emit(errorgetAllPostState());
  });
}

void likePost(String postId)
 {
   FirebaseFirestore.instance.collection('posts')
       .doc(postId).collection('like').doc(userModel!.uId).
       set({'like':true}).then((value){
         emit(successLikeState());
   }).catchError((onError){
       emit(errorLikeState());
   });
 }

 void commentPost(String postId)
 {
   FirebaseFirestore.instance.collection('posts')
       .doc(postId).collection('comments').doc(userModel!.uId)
       .set({'comment':true}).then((value){
     emit(successCommentState());
   }).catchError((onError){
     emit(errorCommentState());
   });
 }

 List<createUserModel> user =[];
 void getAllusers()
 {
   emit(loadinggetAllUsersState());
   if(user.length ==0)
   FirebaseFirestore.instance.collection('users').get().then((value){
     value.docs.forEach((element)
     {
       if(element.data()['uId']!=userModel!.uId)
       user.add(createUserModel.fromjson(element.data()));
       emit(successgetAllUsersState());
     });
   }).catchError((onError){
     emit(errorgetAllUsersState());
   });
 }
 
 void sendMessage({
  required String DateTime,
   required String RecieverId,
   required String text,
})
 {
   MessageModel message = MessageModel(
     dateTime: DateTime,
     receiverId: RecieverId,
     senderId: userModel!.uId,
     text: text,
   );
   FirebaseFirestore.instance.collection('users')
   .doc(userModel!.uId).collection('chats')
   .doc(RecieverId).collection('messages')
   .add(message.toMap()).then((value) {
    emit(successSendMessagesState());
   }).catchError((onError){
    emit(errorSendMessagesState());
   });

   FirebaseFirestore.instance.collection('users')
       .doc(RecieverId).collection('chats')
       .doc(userModel!.uId).collection('messages')
       .add(message.toMap()).then((value) {
     emit(successSendMessagesState());
   }).catchError((onError){
     emit(errorSendMessagesState());
   });
 }

 List<MessageModel> messages =[];
 void getMessages({required String recieverId})
 {
   FirebaseFirestore.instance
       .collection('users')
       .doc(userModel!.uId)
       .collection('chats')
       .doc(recieverId)
       .collection('messages')
       .orderBy('dateTime')
       .snapshots()
       .listen((event)
   {
           messages=[];
           event.docs.forEach((element) {
             messages.add(MessageModel.fromJson(element.data()));
           });
         emit(successGetMessagesState());
   });
 }

 void writeComment({required String text, required String postId})
 {
   emit(loadingSetCommentState());
   CommentModel model = CommentModel(
     postId: postId,
     text: text,
   );
   FirebaseFirestore.instance.collection('posts')
   .doc(postId).collection('comments')
   .add(model.toMap()).then((value){
     emit(successSetCommentState());
   }).catchError((onError){
     emit(errorSetCommentState());

   });
 }

 List<CommentModel> comModel=[];
 void getComment({required postId})
 {
   FirebaseFirestore.instance.collection('posts')
   .doc(postId).collection('comments')
       .snapshots()
       .listen((event){
     event.docs.forEach((element)
     {
       comModel=[];
       comModel.add(CommentModel.fromJson(element.data()));
       emit(successWriteCommentState());
     });
   });
 }

}