import 'package:chat_app/Dio/dio.dart';
import 'package:chat_app/Models/LoginModel.dart';
import 'package:chat_app/Models/createModel.dart';
import 'package:chat_app/Modeules/Register/cubit/RegisterState.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class registerCubit extends Cubit<RegisterStates> {
  registerCubit() :super(initialRegister());

  static registerCubit get(context) => BlocProvider.of(context);
  userModel? user;

  void userRegister({
    required String email,
    required String pass,
    required String name,
    required String phone,

  }) {
    print('hhhhhhhhhhhhhhhhhhhhhhhhhhh');
    emit(loadingRegister());
    FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: pass)
        .then((value){
          userCreate(email: email, uId: value.user!.uid, name: name, phone: phone);
          emit(successRegister());
    }).catchError((e){
      emit(errorRegister(e.toString()));
    });
  }

  void userCreate({
    required String email,
    required String uId,
    required String name,
    required String phone,
  })
  {
    createUserModel user = createUserModel(
        name,
        email,
        phone,
        uId,
        false,
        'https://cdn-icons-png.flaticon.com/512/146/146877.png?w=740&t=st=1664137229~exp=1664137829~hmac=1b5199b8e3b84dc3b97849f0b1bc9fa15caecdef2c42664c56835662a30dc8d7',
        'write your bio ...'
    ,   'https://img.freepik.com/free-photo/amused-pretty-girl-with-curly-afro-hair-raises-palms-has-cheerful-expression-smiles-broadly-sees-something-funny-wears-white-sweater_273609-43437.jpg?w=1060&t=st=1664138246~exp=1664138846~hmac=6fa479f038232096cbf75962e0276de555264088004db36741d265599574d0dd'
    );
    FirebaseFirestore.instance.
    collection('users').
    doc(uId).set(user.toMap()).then((value){
      print('hhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhh');
      emit(successCreateUser());
    }).catchError((e){
      print('jjjjjjjjjjjjjjjjjjjjjjjjjjj');
      emit(errorCreateUser(e));
    });
  }

  bool ispass = true;
  IconData suffix = Icons.visibility_outlined;

  void visibChange() {
    ispass = !ispass;
    suffix = ispass ? Icons.visibility_outlined : Icons.visibility_off_outlined;
    emit(successChangeRegister());
  }

/*userModel ?registerSettigs;
  void getSettingsData()
  {
    emit(loadingSettingsRegister());
    DioHelper.getData(
        url: 'profile',
        token: token
    ).then((value){
      registerSettigs = userModel.fromjson(value.data);
      //print(homeModel!.status);
      //print("hhhhhhhhhhhhhhhhh ${homeModel!.data!.banners[0].image}");
      emit(successSettingsRegister());
    }).catchError((onError){
      print(onError.toString());
      emit(errorSettingsRegister(onError));
    });
  }*/
}