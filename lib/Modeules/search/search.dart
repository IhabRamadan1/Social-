import 'package:chat_app/Models/commentModel.dart';
import 'package:chat_app/Models/createModel.dart';
import 'package:chat_app/Models/postModel.dart';
import 'package:chat_app/layouts/cubit/soCubit.dart';
import 'package:chat_app/layouts/cubit/soStates.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CommentScreen extends StatelessWidget {

  static var commentController = TextEditingController();
   postModel Postmodel;
   CommentScreen({required this.Postmodel});
  @override
  Widget build(BuildContext context) {
    return Builder(

      builder: (BuildContext context)
      {
        AppCubit.get(context).getComment(postId: Postmodel.uId);
        return BlocConsumer<AppCubit,AppStates>(
          listener: (context,state){},
          builder: (context,state)
          {
            return Scaffold(
              appBar: AppBar(
                leading: IconButton(
                  onPressed: (){
                    Navigator.pop(context);
                  },
                  icon: Icon(Icons.arrow_back_ios_outlined, color: Colors.black,),
                ),
                titleSpacing: 0,
                title: Text('Comments'),
              ),

              body: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children:
                  [
                    Expanded(
                      child: ListView.separated(
                          physics: BouncingScrollPhysics(),
                          itemBuilder: (context,index)=>buildComment(AppCubit.get(context).userModel!,
                              AppCubit.get(context).comModel[index],
                              context),
                          separatorBuilder: (context,index)=>SizedBox(
                            height: 10,
                          ),
                          itemCount:  AppCubit.get(context).comModel.length
                      ),
                    ),
                    Spacer(),
                    Container(
                      clipBehavior: Clip.antiAliasWithSaveLayer,
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.grey,
                          width: 1,
                        ),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 15.0,
                              ),
                              child: TextFormField(
                                controller: commentController,
                                keyboardType: TextInputType.name,
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: 'type your comment here ...',
                                ),
                              ),
                            ),
                          ),
                          Container(
                            height: 50.0,
                            color: Colors.blue[300],
                            child: MaterialButton(
                              onPressed: () {
                                 AppCubit.get(context).writeComment(
                                     text: commentController.text,
                                     postId: Postmodel.uId!,
                                 );
                              },
                              minWidth: 1.0,
                              child: Icon(
                                Icons.send,
                                size: 16.0,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }
}
Widget buildComment(createUserModel model, CommentModel comModel ,context)=>
    Container(
      padding: EdgeInsets.symmetric(
        vertical: 5,
        horizontal: 10,
      ),
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.grey,
          width: 1,
        ),
        borderRadius: BorderRadius.circular(10),
      ),
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
                  child: Text('${model.name}',
                    style: Theme.of(context).textTheme.subtitle1!.copyWith(
                        height: 1.4
                    ),
                  )
              ),
            ],
          ),
          SizedBox(height: 5,),
          Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 10,
              horizontal: 20,
            ),
            child: Text('${comModel.text}'),
          ),
        ],
      ),
    );