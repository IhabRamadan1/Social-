import 'package:chat_app/Modeules/Login/LoginScreen.dart';
import 'package:chat_app/Modeules/Register/cubit/RegisterCubit.dart';
import 'package:chat_app/Modeules/Register/cubit/RegisterState.dart';
import 'package:chat_app/shared/Network/Remote/CacheHelper.dart';
import 'package:chat_app/layouts/social_layout.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:conditional_builder/conditional_builder.dart';


class RegisterScreen extends StatelessWidget {

  var emailController = TextEditingController();
  var passController = TextEditingController();
  var passwController = TextEditingController();
  var nameController = TextEditingController();
  var phoneController = TextEditingController();

  var formkey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context)=> registerCubit(),
      child: BlocConsumer<registerCubit,RegisterStates>(
        listener:(context,state){
         if(state is errorRegister)
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
         if(state is successCreateUser)
           {
             Navigator.pushAndRemoveUntil(context,
                 MaterialPageRoute(builder: (context)=>LoginScreen())
                 , (route) => false);
           }
        } ,
        builder:(context,state)
        {
          return Scaffold(
            appBar: AppBar(),
            body: Center(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(25.0),
                  child: Form(
                    key: formkey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "REGISTER",
                          style: Theme.of(context).textTheme.headline4!.copyWith(color: Colors.black),
                        ),
                        SizedBox(height: 5,),
                        Text(
                          "register now to communicate with friends  ",
                          style: Theme.of(context).textTheme.bodyText1!.copyWith(color: Colors.grey),

                        ),
                        SizedBox(height: 20,),
                        TextFormField(
                          controller: nameController,
                          keyboardType: TextInputType.emailAddress,
                          decoration: InputDecoration(
                            labelText: "Username",
                            prefixIcon: Icon(Icons.person),
                            border: OutlineInputBorder(),
                          ),
                          validator: (value)
                          {
                            if(value!.isEmpty)
                            {
                              return 'please enter your name';
                            }
                          },

                        ),
                        SizedBox(height: 15,),
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
                          controller: phoneController,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            labelText: "Phone",
                            prefixIcon: Icon(Icons.phone),
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
                          obscureText: registerCubit.get(context).ispass,
                          keyboardType: TextInputType.visiblePassword,
                          decoration: InputDecoration(
                            labelText: "Password",
                            prefixIcon: Icon(Icons.lock),
                            suffixIcon: IconButton(
                              onPressed: (){
                                //shopCubit.get(context).visibChange();
                                registerCubit.get(context).visibChange();
                              },
                              icon: Icon(registerCubit.get(context).suffix),
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
                        SizedBox(height: 15,),
                        TextFormField(
                          controller: passwController,
                          obscureText: registerCubit.get(context).ispass,
                          keyboardType: TextInputType.visiblePassword,
                          decoration: InputDecoration(
                            labelText: "Confirm Password",
                            prefixIcon: Icon(Icons.lock),
                            suffixIcon: IconButton(
                              onPressed: (){
                                //shopCubit.get(context).visibChange();
                                registerCubit.get(context).visibChange();
                              },
                              icon: Icon(registerCubit.get(context).suffix),
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
                            condition: state is! loadingRegister,
                            builder: (context)=> MaterialButton(
                              onPressed:(){
                                if(formkey.currentState!.validate())
                                {
                                  if(passController.text == passwController.text)
                                  {
                                    registerCubit.get(context).userRegister(
                                        email: emailController.text,
                                        pass: passController.text,
                                        name: nameController.text,
                                        phone: phoneController.text);
                                  }
                                  else{
                                    Fluttertoast.showToast(
                                        msg: "your password don/'t match",
                                        toastLength: Toast.LENGTH_SHORT,
                                        gravity: ToastGravity.BOTTOM,
                                        timeInSecForIosWeb: 5,
                                        backgroundColor: Colors.green,
                                        textColor: Colors.white,
                                        fontSize: 16.0
                                    );

                                  }
                                  // shopCubit.get(context).userLogin(email: emailController.text, pass: passController.text);

                                }
                              },
                              color: Colors.blue,
                              child: Text(
                                "REGISTER",
                                style: TextStyle(

                                ),
                              ),
                            ),
                            fallback: (context)=> Center(child: CircularProgressIndicator()) ,
                          ),
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