import 'package:chat_app/Modeules/editProfile/editProfile.dart';
import 'package:chat_app/layouts/cubit/soCubit.dart';
import 'package:chat_app/layouts/cubit/soStates.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class settingsScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit,AppStates>(
      listener: (context,state){},
      builder: (context,state){
        var model = AppCubit.get(context).userModel;
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Container(
                height: 200,
                child: Stack(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadiusDirectional.only(
                            topStart: Radius.circular(4),
                            topEnd: Radius.circular(4),
                          ),
                          image: DecorationImage(
                            image: NetworkImage('${model!.cover}',
                            ),fit: BoxFit.cover,
                          )

                      ),
                      height: 150,
                      width: double.infinity,
                    ),
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: CircleAvatar(

                        radius: 64,
                        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                        child: CircleAvatar(
                          radius:60,
                          backgroundImage: NetworkImage('${model!.image}'),

                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 7,),
              Text('${model.name}',
                style: Theme.of(context).textTheme.bodyText1,
              ),
              SizedBox(height: 5,),
              Text(
                '${model.bio}', style: Theme.of(context).textTheme.caption,),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Row(
                  children: [
                    Expanded(
                      child: InkWell(
                        onTap: (){},
                        child: Column(
                          children: [
                            Text('100',
                              style: Theme.of(context).textTheme.bodyText1,
                            ),
                            SizedBox(height: 5,),
                            Text('Posts',
                              style: Theme.of(context).textTheme.caption,
                            ),
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      child: InkWell(
                        onTap: (){},
                        child: Column(
                          children: [
                            Text('256',
                              style: Theme.of(context).textTheme.bodyText1,
                            ),
                            SizedBox(height: 5,),

                            Text('Photos',
                              style: Theme.of(context).textTheme.caption,
                            ),
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      child: InkWell(
                        onTap: (){},
                        child: Column(
                          children: [   Text('10k',
                            style: Theme.of(context).textTheme.bodyText1,
                          ),
                            SizedBox(height: 5,),

                            Text('Followers',
                              style: Theme.of(context).textTheme.caption,
                            ),
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      child: InkWell(
                        onTap: (){},
                        child: Column(
                          children: [
                            Text('64',
                              style: Theme.of(context).textTheme.bodyText1,
                            ),
                            SizedBox(height: 5,),

                            Text('Followings',
                              style: Theme.of(context).textTheme.caption,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 5,),
              Row(
                children: [
                  Expanded(
                    child: Container(
                      width: double.infinity,
                      height: 40,
                      child: OutlinedButton(
                        onPressed: (){},
                        child: Text(
                          'Add photos',
                          style: TextStyle(
                            color: Colors.blue[300],
                          ),
                        ),
                      ),
                    ),
                  ),
                 SizedBox(width: 5,),
                 OutlinedButton(onPressed: (){
                   Navigator.push(context, MaterialPageRoute(builder: (context)=>editProfileScreen()));
                 },
                     child: Icon(Icons.edit)),
                ],
              ),

            ],
          ),
        );
      },
    );
  }
}