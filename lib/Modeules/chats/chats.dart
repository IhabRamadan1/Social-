import 'package:chat_app/Models/createModel.dart';
import 'package:chat_app/Modeules/chats/chatDtails.dart';
import 'package:chat_app/layouts/cubit/soCubit.dart';
import 'package:chat_app/layouts/cubit/soStates.dart';
import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class chatScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit,AppStates>(
      listener: (context,state){},
      builder: (context,state){
        return  Scaffold(
          body: ConditionalBuilder(
            condition: AppCubit.get(context).user.length > 0,
            builder: (context)=>ListView.separated(
                itemBuilder: (context,index)=>chatBuilder(AppCubit.get(context).user[index],context),
                separatorBuilder: (context,index)=>Container(
                  width: double.infinity,
                  height: 1,
                  color: Colors.grey[700],
                ),
                itemCount: AppCubit.get(context).user.length),
            fallback: (context)=>Center(child: CircularProgressIndicator(),),
          ),
        );
      },
    );
  }
  Widget chatBuilder(createUserModel model, context)=> InkWell(
    onTap: (){
      Navigator.push(context, MaterialPageRoute(builder: (context)=>chatDetailsScreen(
        model: model,
      )));
    },
    child: Padding(
      padding: const EdgeInsets.all(20.0),
      child: Row(
        children: [
          CircleAvatar(
            radius: 25,
            backgroundImage: NetworkImage('${model.image}'),
          ),
          SizedBox(width: 20,),
          Text('${model.name}',
            style: TextStyle(fontWeight: FontWeight.w500, fontSize: 17),
          ),
        ],
      ),
    ),
  );
}