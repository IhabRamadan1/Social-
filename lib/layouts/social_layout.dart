
import 'package:chat_app/Modeules/addPost/addPost.dart';
import 'package:chat_app/layouts/cubit/soCubit.dart';
import 'package:chat_app/layouts/cubit/soStates.dart';
import 'package:chat_app/shared/styles/icon_broken.dart';
import 'package:conditional_builder/conditional_builder.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';

class socialLayout extends StatelessWidget {

  const socialLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit,AppStates>(
      listener: (context,state){
        if(state is AddPostState)
          {
            Navigator.push(context, MaterialPageRoute(builder: (context)=> postScreen(),));
          }
      },
      builder: (context,state)
      {
        return Scaffold(
          appBar: AppBar(
            title: Text(AppCubit.get(context).titles[AppCubit.get(context).currentIndex]),
            actions: [
              IconButton(onPressed: (){}, icon: Icon(Icons.notifications_on_outlined,
              color: Colors.black,
              )),
              IconButton(onPressed: (){}, icon: Icon(Icons.search,              color: Colors.black,
              )),
            ],
           ),
          body: AppCubit.get(context).screens[AppCubit.get(context).currentIndex],
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: AppCubit.get(context).currentIndex,
            onTap: (index)
            {
              AppCubit.get(context).bottomChange(index);
            },
            items:
            [
              BottomNavigationBarItem(
                  icon: Icon(Icons.home),
                label: 'Home'
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.chat),
                label: 'Chat'
              ),
              BottomNavigationBarItem(
                  icon: Icon(Icons.upload_file),
                  label: 'Post'
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.location_on_outlined),
                  label: 'Users'

              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.settings),
                  label: 'Settings'

              )

            ],
          ),
        );
      },
    );
  }
}

/* //if(!(Mod!.isVerified)!)
                    Container(
                      color: Colors.amber.withOpacity(0.6),
                      height: 70,
                      child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Row(
                          children: [
                            Icon(Icons.info_outline),
                            SizedBox(width: 15,),
                            Text('Please verify your email'),
                            SizedBox(width: 20,),
                            Spacer(),
                            TextButton(onPressed: (){
                              FirebaseAuth.instance.currentUser!.sendEmailVerification(
                              ).then((value){
                                Fluttertoast.showToast(msg: 'check your email',
                                );
                              });
                            }, child: Text('Send')),
                          ],
                        ),
                      ),
                    ),*/