import 'package:chat_app/Models/createModel.dart';
import 'package:chat_app/Models/messageModel.dart';
import 'package:chat_app/layouts/cubit/soCubit.dart';
import 'package:chat_app/layouts/cubit/soStates.dart';
import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class chatDetailsScreen extends StatelessWidget
{
  static var messageController = TextEditingController();
  createUserModel? model;
  chatDetailsScreen({this.model});
  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (BuildContext context)
      {
        AppCubit.get(context).getMessages(recieverId: model!.uId!);
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
                title: Row(
                  children: [
                    CircleAvatar(
                      radius: 20,
                      backgroundImage:NetworkImage('${model!.image}'),
                    ),
                    SizedBox(width: 5,),
                    Text('${model!.name}'),
                  ],
                ),
              ),
              body: ConditionalBuilder(
                condition:AppCubit.get(context).messages.length>0,
                builder: (context)=>Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    children: [
                      Expanded(
                        child: ListView.separated(
                          physics: BouncingScrollPhysics(),
                          itemBuilder: (context,index)
                          {
                            var message = AppCubit.get(context).messages[index];
                            if(AppCubit.get(context).userModel!.uId == message.senderId)
                              return buildMyMessage(message);

                            return buildMyMessage(message);
                          },
                          separatorBuilder: (context,index)=>SizedBox(
                            height: 15,
                          ),
                          itemCount: AppCubit.get(context).messages.length,
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
                                  controller: messageController,
                                  keyboardType: TextInputType.name,
                                  decoration: InputDecoration(
                                    border: InputBorder.none,
                                    hintText: 'type your message here ...',
                                  ),
                                ),
                              ),
                            ),
                            Container(
                              height: 50.0,
                              color: Colors.blue[300],
                              child: MaterialButton(
                                onPressed: () {
                                  AppCubit.get(context).sendMessage(
                                    RecieverId: model!.uId!,
                                    DateTime: DateTime.now().toString(),
                                    text: messageController.text,
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
                fallback: (context)=>Center(child: CircularProgressIndicator(),),
              ),
            );
          },
        );
      },
    );
  }
  Widget builMessage(MessageModel model)=>Align(
    alignment: AlignmentDirectional.centerStart,
    child: Container(
      padding: EdgeInsets.symmetric(
        vertical: 5,
        horizontal: 10,
      ),                decoration: BoxDecoration(
      color: Colors.grey[300],
      borderRadius: BorderRadiusDirectional.only(
        topEnd: Radius.circular(10),
        bottomEnd: Radius.circular(10),
        topStart: Radius.circular(10),

      ),
    ),
      child: Text('${model.text}'),
    ),
  );
  Widget buildMyMessage(MessageModel model)=>Align(
    alignment: AlignmentDirectional.centerEnd,
    child: Container(
      padding: EdgeInsets.symmetric(
        vertical: 5,
        horizontal: 10,
      ),
      decoration: BoxDecoration(
        color: Colors.blue[300],
        borderRadius: BorderRadiusDirectional.only(
          topEnd: Radius.circular(10),
          bottomStart: Radius.circular(10),
          topStart: Radius.circular(10),

        ),
      ),
      child: Text('${model.text}'),
    ),
  );

}



