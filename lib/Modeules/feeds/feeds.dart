
 import 'package:chat_app/Models/postModel.dart';
import 'package:chat_app/Modeules/search/search.dart';
import 'package:chat_app/layouts/cubit/soCubit.dart';
import 'package:chat_app/layouts/cubit/soStates.dart';
import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class feedsScreen extends StatelessWidget {

   @override
   Widget build(BuildContext context) {
     return BlocConsumer<AppCubit,AppStates>(
       listener: (context,state){},
       builder: (context,state){
         return Scaffold(
           body:
           ConditionalBuilder(
             condition: AppCubit.get(context).posts.length>0,
             builder: (context)=>SingleChildScrollView(
               physics: BouncingScrollPhysics(),
               child: Column(
                 children: [
                   SizedBox(height: 5,),
                   Stack(
                     alignment: AlignmentDirectional.topEnd,
                     children: [
                       Card(
                         clipBehavior: Clip.antiAliasWithSaveLayer,
                         elevation: 10,
                         margin: EdgeInsets.all(8),
                         child: Image(
                           width: double.infinity,
                           height: 200,
                           image: NetworkImage('https://img.freepik.com/free-photo/horizontal-shot-good-looking-afro-american-woman-feels-very-happy-holds-modern-smartphone-hand-wears-stereo-headphones-points-aside-blank-space-blue-background-leisure-concept_273609-45236.jpg?w=996&t=st=1664119980~exp=1664120580~hmac=e326ff4e34bc3d533e2bb81d59c0bbb2a0be67c26f8e27fe2c8e02207bb8e82d'
                           ),
                           fit: BoxFit.cover,
                         ),
                       ),
                       Padding(
                         padding: const EdgeInsets.symmetric(vertical: 70, horizontal: 15),
                         child: Text('communicate with friends',
                           style: Theme.of(context).textTheme.subtitle1!.copyWith(
                             color: Colors.white,
                           ),
                         ),
                       )
                     ],
                   ),
                   ListView.separated(
                     shrinkWrap: true,
                     physics: NeverScrollableScrollPhysics(),
                     itemBuilder: (context,index)=> buildPostItem(context,AppCubit.get(context).posts[index],index),
                     separatorBuilder:(context,index)=> SizedBox(height: 0,),
                     itemCount: AppCubit.get(context).posts.length,
                   ),
                   SizedBox(height: 8,),
                 ],
               ),
             ),
             fallback:(context)=> Center(child: CircularProgressIndicator()),
           ),
         );
       },
     );
   }
 }
 Widget buildPostItem(context, postModel model, index) => Card(
   elevation: 5,
   clipBehavior: Clip.antiAliasWithSaveLayer,
   child: Padding(
     padding: const EdgeInsets.all(10.0),
     child: Column(
       crossAxisAlignment: CrossAxisAlignment.start,
       children: [
         Row(
           children: [
             CircleAvatar(
                 radius: 25,
                 backgroundImage: NetworkImage('${model.image}'),
             ),
             SizedBox(width: 20,),
             Expanded(
                 child: Column(
                   crossAxisAlignment: CrossAxisAlignment.start,
                   children: [
                     Row(
                       children: [
                         Text('${model.name}',
                           style: Theme.of(context).textTheme.subtitle1!.copyWith(
                               height: 1.4
                           ),
                         ),
                         SizedBox(width: 5,),
                         Icon(Icons.check_circle, size: 16, color: Colors.blue,)
                       ],
                     ),
                     Text('${model.DatTime}',
                       style:Theme.of(context).textTheme.caption!.copyWith(
                           height: 1.4
                       ),
                     ),
                   ],
                 )
             ),
             //Spacer(),
             IconButton(onPressed: (){}, icon: Icon(Icons.more_horiz)),
           ],
         ),
         Padding(
           padding: const EdgeInsets.symmetric(
             vertical: 10,
           ),
           child: Container(
             height: 1,
             color: Colors.grey[300],
           ),
         ),
         SizedBox(height: 5,),
         Text( '${model.text}',
           style: Theme.of(context).textTheme.subtitle1!.copyWith(
             height: 1.3,
             fontSize: 14,
           ),
         ),
         /*         Padding(
           padding: const EdgeInsets.only(
             bottom: 5,
             top: 5,
           ),
          child: Container(
             width: double.infinity,
             child: Wrap(
               //alignment: WrapAlignment.start,
               //crossAxisAlignment: WrapCrossAlignment.start,
               children:
               [
                 Padding(
                   padding: const EdgeInsetsDirectional.only(
                     end: 6,
                   ),
                   child: Container(
                     height: 25,
                     child: MaterialButton(
                       onPressed: (){},
                       child: Text(
                         '#software',
                         style: TextStyle(
                           color: Colors.blue,
                         ),
                       ),
                     ),
                   ),
                 ),
                 Padding(
                   padding: const EdgeInsetsDirectional.only(
                     end: 6,
                   ),
                   child: Container(
                     height: 25,
                     child: MaterialButton(
                       onPressed: (){},
                       child: Text(
                         '#Flutter',
                         style: TextStyle(
                           color: Colors.blue,
                         ),
                       ),
                     ),
                   ),
                 ),
               ],
             ),
           ),
         ),
*/
         if(model.PostImage!='')
         Padding(
           padding: const EdgeInsets.only(top: 5),
           child: Container(
             width: double.infinity,
             height: 140,
             decoration: BoxDecoration(
               borderRadius: BorderRadius.circular(5),
               image: DecorationImage(
                 image: NetworkImage('${model.PostImage}'),
                 fit: BoxFit.cover,
               ),
             ),
           ),
         ),
         Row(
           mainAxisAlignment: MainAxisAlignment.start,
           //ainAxisSize: MainAxisSize.max,
           children: [
             Expanded(
               flex: 1,
               child: InkWell(
                 onTap: (){},
                 child: Padding(
                   padding: const EdgeInsets.symmetric(
                     vertical: 10,
                   ),
                   child: Row(
                     children: [
                       Icon(Icons.favorite_border, color: Colors.red,size: 16,),
                       SizedBox(width: 5,),
                       Text('${AppCubit.get(context).likes[index]}', style: Theme.of(context).textTheme.caption,),
                     ],
                   ),
                 ),
               ),
             ),
             Expanded(
               flex: 1,
               child: InkWell(
                 onTap: (){},
                 child: Padding(
                   padding: const EdgeInsets.symmetric(
                     vertical: 10,
                   ),
                   child: Row(
                     mainAxisAlignment: MainAxisAlignment.end,
                     children: [
                       Icon(Icons.comment, color: Colors.yellowAccent,size: 16,),
                       SizedBox(width: 5,),
                       Text(
                         '${AppCubit.get(context).comments[index]}',
                         style: Theme.of(context).textTheme.caption,),
                     ],
                   ),
                 ),
               ),
             ),
           ],
         ),
         Padding(
           padding: const EdgeInsetsDirectional.only(
             top: 5,
             bottom: 5,
           ),
           child: Container(
             height: 1,
             width: double.infinity,
             color: Colors.grey[300],
           ),
         ),
         Row(
           children: [
             Expanded(
               child: Padding(
                 padding: const EdgeInsets.symmetric(
                   vertical: 5,
                 ),
                 child: InkWell(
                   onTap: (){
                     Navigator.push(context,
                     MaterialPageRoute(builder: (context)=>
                         CommentScreen(
                           Postmodel: model,
                         ))
                     );
                   },
                   child: Row(
                     children: [
                       CircleAvatar(
                         radius: 18,
                         backgroundImage: NetworkImage(
                             '${AppCubit.get(context).userModel!.image}'
                         ),
                       ),
                       SizedBox(width: 15,),
                       Text(
                          'write a comment..',
                       ),
                     ],
                   ),
                 ),
               ),
             ),
             Container(
               height: 50,
               width: 70,
               child: InkWell(
                 onTap: (){
                   AppCubit.get(context).likePost(AppCubit.get(context).PostId[index]);
                 },
                 child: Padding(
                   padding: const EdgeInsets.symmetric(
                     vertical: 5,
                   ),
                   child: Row(
                     mainAxisAlignment: MainAxisAlignment.end,
                     children: [
                       Icon(Icons.favorite_border, color: Colors.red, size: 16,),
                       SizedBox(width: 5,),
                       Text('Like', style: Theme.of(context).textTheme.caption,),
                     ],
                   ),
                 ),
               ),
             ),
           ],
         ),
       ],
     ),
   ),
 );

