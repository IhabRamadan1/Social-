import 'package:chat_app/Dio/dio.dart';
import 'package:chat_app/Modeules/Login/LoginScreen.dart';
import 'package:chat_app/Modeules/Login/cubit/cubit.dart';
import 'package:chat_app/Network/Remote/CacheHelper.dart';
import 'package:chat_app/constants.dart';
import 'package:chat_app/layouts/cubit/soCubit.dart';
import 'package:chat_app/layouts/cubit/soStates.dart';
import 'package:chat_app/layouts/social_layout.dart';
import 'package:chat_app/styles/themes.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  DioHelper.init();
  await cachHelper.init();
  Widget startWidget;
  uId = cachHelper.gatDa(key: 'uId');
  if (uId != null)
    {
      startWidget = socialLayout();
    }
  else{
    startWidget = LoginScreen();
  }
  runApp( MyApp(
    widget: startWidget,
  ));
}

class MyApp extends StatelessWidget {
  final Widget widget;

  const MyApp({super.key, required this.widget});


  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context)=> AppCubit()..getUserData()..getAllPosts()..getAllusers(),
      child: BlocConsumer<AppCubit,AppStates>(
        listener: (context,state) {} ,
        builder: (context,state)
        {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: light,
            home: widget,
          );
        },
        ),
    );
  }
}

