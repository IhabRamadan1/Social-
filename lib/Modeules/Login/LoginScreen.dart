import 'package:chat_app/Modeules/Login/cubit/cubit.dart';
import 'package:chat_app/Modeules/Login/cubit/state.dart';
import 'package:chat_app/Modeules/Register/registerScreen.dart';
import 'package:chat_app/Network/Remote/CacheHelper.dart';
import 'package:chat_app/layouts/social_layout.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
//import 'package:untitled/Modules/Register/RegisterScreen.dart';
//import 'package:untitled/Network/Remote/sharedPref.dart';
//import 'package:untitled/constant/constants.dart';
//import 'package:untitled/cubit/shopCubit.dart';
//import 'package:untitled/cubit/shopstate.dart';
//import 'package:untitled/layouts/shopScreen.dart';
import 'package:conditional_builder/conditional_builder.dart';

//import '../cubit/state.dart';


class LoginScreen extends StatelessWidget {

  var emailController = TextEditingController();
  var passController = TextEditingController();
  var formkey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context)=> socialCubit(),
      child: BlocConsumer<socialCubit,socialState>(
        listener:(context,state){
          if(state is errorSocial)
          {
            Fluttertoast.showToast(
                msg: state.error,
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.BOTTOM,
                timeInSecForIosWeb: 5,
                backgroundColor: Colors.red,
                textColor: Colors.white,
                fontSize: 16.0);
          }
          if(state is successSocial)
            {
              cachHelper.saveData(
                  key: 'uId',
                  value: state.uId,
              ).then((value){
                    Navigator.pushAndRemoveUntil(context,
                        MaterialPageRoute(builder: (context)=>socialLayout() ), (route) => false);
              });
            }
        } ,
        builder:(context,state)
        {
          return Scaffold(
            appBar: AppBar(),
            body: Center(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Form(
                    key: formkey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "LOGIN",
                          style: Theme.of(context).textTheme.headline4!.copyWith(color: Colors.black),
                        ),
                        SizedBox(height: 5,),
                        Text(
                          "Login now to communicate with friends ",
                          style: Theme.of(context).textTheme.bodyText1!.copyWith(color: Colors.grey),

                        ),
                        SizedBox(height: 20,),
                        TextFormField(
                          controller: emailController,
                          keyboardType: TextInputType.emailAddress,
                          decoration: InputDecoration(
                            labelText: "Email",
                            prefixIcon: Icon(Icons.email_outlined),
                            border: OutlineInputBorder(),
                          ),
                          validator: (value)
                          {
                            if(value!.isEmpty)
                            {
                              return 'please enter your email';
                            }
                          },

                        ),
                        SizedBox(height: 15,),
                        TextFormField(
                          controller: passController,
                          obscureText: socialCubit.get(context).ispass,
                          keyboardType: TextInputType.visiblePassword,
                          decoration: InputDecoration(
                            labelText: "Password",
                            prefixIcon: Icon(Icons.lock),
                            suffixIcon: IconButton(
                              onPressed: (){
                                socialCubit.get(context).visibChange();
                              },
                              icon: Icon(socialCubit.get(context).suffix),
                            ),

                            border: OutlineInputBorder(),
                          ),
                          validator: (value)
                          {
                            if(value!.isEmpty)
                            {
                              return 'please enter your password';
                            }
                          },
                        ),
                        SizedBox(height: 20,),
                        Container(
                          width: double.infinity,
                          height: 50,
                          child: ConditionalBuilder(
                            condition: state is! loadingSocial,
                            builder: (context)=> MaterialButton(
                              onPressed:(){
                                if(formkey.currentState!.validate())
                                {
                                  //Navigator.pushAndRemoveUntil(context,
                                  //  MaterialPageRoute(builder: (context)=>helloScreen())
                                  //, (route) => false);
                                  socialCubit.get(context).userLogin(email: emailController.text, pass: passController.text);

                                }
                              },
                              color: Colors.blue,
                              child: Text(
                                "LOGIN",
                                style: TextStyle(

                                ),
                              ),
                            ),
                            fallback: (context)=> Center(child: CircularProgressIndicator()) ,
                          ),
                        ),
                        SizedBox(height: 5,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("Don\'t have an email?"),
                            SizedBox(width: 2,),
                            TextButton(
                                onPressed:()
                                {
                                  Navigator.push(context, MaterialPageRoute(builder: (context)=>RegisterScreen()));
                                },
                                child: Text("Register",
                                  style: TextStyle(
                                    color: Colors.blue,
                                  )
                                  ,)),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}