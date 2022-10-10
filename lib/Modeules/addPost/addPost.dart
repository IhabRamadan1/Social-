import 'package:chat_app/layouts/cubit/soCubit.dart';
import 'package:chat_app/layouts/cubit/soStates.dart';
import 'package:chat_app/layouts/social_layout.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class postScreen extends StatelessWidget {

  var textC = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit,AppStates>(
      listener: (context,state){},
      builder: (context,state)
      {
        var prostImage = AppCubit.get(context).postImage;

        return Scaffold(
            appBar: AppBar(
              leading: IconButton(
                onPressed: (){
                  Navigator.pushAndRemoveUntil(context,
                      MaterialPageRoute(builder: (context)=>socialLayout()), (route) => false);
                },
                icon: Icon(Icons.arrow_back_ios_outlined, color: Colors.black,),
              ),
              title: Text('Create Post'),
              actions: [
                TextButton(onPressed: (){
                  if(AppCubit.get(context).postImage== null)
                  AppCubit.get(context).createPost(DatTime: DateTime.now().toString(), text: textC.text);
                  if(AppCubit.get(context).postImage!= null)
                    AppCubit.get(context).uploadPostImage(Datetime: DateTime.now().toString(), text: textC.text);

                }, child: Text('POST',
                style: Theme.of(context).textTheme.bodyText1!.copyWith(
                  color: Colors.blue[400],
                ),
                ),),
              ],
            ),
             body: Padding(
               padding: const EdgeInsets.all(20.0),
               child: Column(
                 children: [
                   if(state is loadingCreatePostState)
                     LinearProgressIndicator(),
                   if(state is loadingCreatePostState)
                     SizedBox(width: 5,),
                     Row(
                    children: [
                      CircleAvatar(
                      radius: 25,
                      backgroundImage: NetworkImage('https://img.freepik.com/free-photo/amused-pretty-girl-with-curly-afro-hair-raises-palms-has-cheerful-expression-smiles-broadly-sees-something-funny-wears-white-sweater_273609-43437.jpg?w=996&t=st=1664121208~exp=1664121808~hmac=4e0e91cbcfaf4d82f4738546b9dd4313867d27f42cf61685fa34150b6219b8f9',)
            ),
                      SizedBox(width: 10,),
                      Text('Ihab Ramadan',
                        style: Theme.of(context).textTheme.bodyText2!.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
            ),
                     Expanded(
                     child: TextFormField(
                       controller: textC,
                       maxLines: 30,
                       decoration: InputDecoration(
                         hintText: 'what is on your mind...',
                         border: InputBorder.none,
                       ),
                     ),
                   ),
                   if(AppCubit.get(context).postImage!=null)
                   Stack(
                     alignment: AlignmentDirectional.topEnd,
                     children: [
                       Container(
                         decoration: BoxDecoration(
                             borderRadius: BorderRadius.circular(10),
                             image: DecorationImage(
                               image:  FileImage(prostImage!) as ImageProvider,
                               fit: BoxFit.cover,
                             )

                         ),
                         height: 150,
                         width: double.infinity,
                       ),
                       Padding(
                         padding: const EdgeInsets.all(10.0),
                         child: CircleAvatar(
                           backgroundColor: Colors.red[250],
                           radius: 20,
                           child: IconButton(onPressed: (){
                             AppCubit.get(context).removePostImage();
                           },
                               icon: Icon(Icons.close, size: 16,)
                           ),
                         ),
                       ),
                     ],
                   ),
                   SizedBox(height: 10,),
                   Row(
                     mainAxisAlignment: MainAxisAlignment.center,
                     children: [
                       Expanded(
                         child: TextButton(
                             onPressed: (){
                               AppCubit.get(context).getPostImage();
                             },
                             child: Row(
                               children: [
                                 Icon(Icons.image),
                                 SizedBox(width: 5,),
                                 Text('add photo'),
                               ],
                             ),
                         ),
                       ),
                       Expanded(
                         child: TextButton(
                           onPressed: (){},
                           child: Text('#tags'),
                         ),
                       ),
                     ],
                   ),

                 ],
               ),
             ),
        );
      },
    );
  }
}
