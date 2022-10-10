import 'package:chat_app/Modeules/settings/settings.dart';
import 'package:chat_app/layouts/cubit/soCubit.dart';
import 'package:chat_app/layouts/cubit/soStates.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class editProfileScreen extends StatelessWidget {
  var nameC = TextEditingController();
  var bioC = TextEditingController();
  var phoneC = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit,AppStates>(
      listener: (context,state){},
      builder: (context,state){
        var model = AppCubit.get(context).userModel;
        var profileImage = AppCubit.get(context).profileImage;
        var coverImage = AppCubit.get(context).coverImage;
        nameC.text = model!.name??'';
        bioC.text = model!.bio??'';
        return Scaffold(
          appBar: AppBar(
            leading: IconButton(
              onPressed: (){
                Navigator.pop(context);
              },
              icon: Icon(Icons.arrow_back_ios_new_outlined, color: Colors.black,size: 16,),),
            title: Text('Edit Profile'),

            actions: [
              TextButton(onPressed: (){
                AppCubit.get(context).updateUser(name: nameC.text, phone: phoneC.text, bio: bioC.text);
              },
                  child: Text("Update") ),
              SizedBox(width: 15,),
            ],
          ),
          body:  SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                children: [
                  if(state is loadingUpdateState)
                   LinearProgressIndicator(),
                  SizedBox(height: 5,),
                  Container(
                    height: 200,
                    child: Stack(
                      children: [
                        Stack(
                          alignment: AlignmentDirectional.bottomEnd,
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadiusDirectional.only(
                                    topStart: Radius.circular(4),
                                    topEnd: Radius.circular(4),
                                  ),
                                  image: DecorationImage(
                                    image: coverImage ==null?
                                    NetworkImage('${model.cover}',
                                    ): FileImage(coverImage) as ImageProvider,
                                    fit: BoxFit.cover,
                                  )

                              ),
                              height: 150,
                              width: double.infinity,
                            ),
                            Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: CircleAvatar(
                                backgroundColor: Colors.blue[250],
                                radius: 20,
                                child: IconButton(onPressed: (){
                                  AppCubit.get(context).getCoverImage();
                                },
                                    icon: Icon(Icons.camera_alt_rounded, size: 16,)
                                ),
                              ),
                            ),
                          ],
                        ),
                        Align(
                          alignment: Alignment.bottomCenter,
                          child: Stack(
                            alignment: AlignmentDirectional.bottomEnd,
                            children: [
                              CircleAvatar(
                                radius: 64,
                                backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                                child: CircleAvatar(
                                  radius:60,
                                  backgroundImage: profileImage == null?
                                  NetworkImage('${model.image}'):
                                  FileImage(profileImage) as ImageProvider,
                                ),
                              ),
                              CircleAvatar(
                                backgroundColor: Colors.blue[150],
                                radius: 18,
                                child: IconButton(onPressed: (){
                                  AppCubit.get(context).getProfileImage();
                                },
                                    icon: Icon(Icons.camera_alt_rounded, size: 16,)
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 20,),
                  if(profileImage!=null || coverImage!=null)
                  Row(
                    children: [
                      if(profileImage!=null)
                      Expanded(child: MaterialButton(
                        color: Colors.blue,
                        onPressed: (){
                            AppCubit.get(context).uploadProfile(name: nameC.text,
                            phone: phoneC.text, bio: bioC.text,
                            );
                          },
                         child: Text('UPLOAD IMAGE'),
                      ),),
                      SizedBox(width: 5,),
                      if(coverImage!=null)
                        Expanded(child: MaterialButton(
                          color: Colors.blue,
                          onPressed: (){
                            AppCubit.get(context).uploadCover(name: nameC.text,
                              phone: phoneC.text, bio: bioC.text,);
                          },
                        child: Text('UPLOAD COVER'),
                      )),
                    ],
                  ),
                  SizedBox(height: 10,),
                  TextFormField(
                    validator: (value)
                    {
                      if(value!.isEmpty)
                      {
                        return 'name must not be empty';
                      }
                      return null;
                    },
                    controller: nameC,
                    keyboardType: TextInputType.name,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.person),
                      labelText: 'Name',
                    ),
                  ),
                  SizedBox(height: 10,),
                  TextFormField(
                    validator: (value)
                    {
                      if(value!.isEmpty)
                      {
                        return 'bio must not be empty';
                      }
                      return null;
                    },
                    controller: bioC,
                    keyboardType: TextInputType.name,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.info_outline),
                      labelText: 'bio',
                    ),
                  ),
                  SizedBox(height: 10,),
                  TextFormField(
                    validator: (value)
                    {
                      if(value!.isEmpty)
                      {
                        return 'phone must not be empty';
                      }
                      return null;
                    },
                    controller: phoneC,
                    keyboardType: TextInputType.phone,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.phone),
                      labelText: 'phone',
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
